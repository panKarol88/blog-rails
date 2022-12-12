shared_examples 'response status' do |status|
  it "responds with #{status}" do
    call
    expect(response).to have_http_status(status)
  end
end

shared_examples 'response status with body' do |status|
  raise 'expected_response_body is not defined' unless method_defined?(:expected_response_body)

  include_examples 'response status', status

  it "responds with #{status} and body" do
    call
    expect(response.body).to eq(expected_response_body)
  end
end

shared_examples 'response status with index ids' do |status|
  raise 'expected_response_ids is not defined' unless method_defined?(:expected_response_ids)

  include_examples 'response status', status

  it "responds with #{status} and index ids" do
    call
    expect(JSON.parse(response.body)['records'].map { |record| record['id'] }).to eq(expected_response_ids)
  end
end

shared_examples 'response with error' do |status = :unprocessable_entity|
  raise 'expected_error_message is not defined' unless method_defined?(:expected_error_message)

  include_examples 'response status', status

  it "responds with #{status} and contains a proper error message" do
    call
    expected_error_message.each do |_attribute, messages|
      expect(response.body).to include(messages) if messages.is_a?(String)
      messages.each{ |message| expect(response.body).to include(message) } if messages.is_a?(Array)
    end
  end
end

shared_examples 'secured endpoint' do |method:, url:, allowed_types: User.types|
  subject(:call) { send(method, url, params:, headers:) }

  let(:headers) { {} }
  let(:params) { {} }
  let(:user) { create(:user, allowed_types.first.to_s.downcase) }
  let(:access_token) { Warden::JWTAuth::TokenEncoder.new.call({ sub: user.id, scp: 'user' }.with_indifferent_access) }

  context 'with correct access token' do
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }

    describe 'with correct permissions' do
      allowed_types.each do |type|
        context "with user with #{type} type" do
          let(:user) { create(:user, type.to_s.downcase) }

          it 'allows access', :aggregate_failures do
            call
            expect(response).not_to have_http_status(:forbidden)
            expect(response).not_to have_http_status(:unauthorized)
          end
        end
      end
    end

    describe 'without correct permissions' do
      (User.types - allowed_types.map(&:to_s)).each do |type|
        context "with user with #{type} type" do
          let(:user) { create(:user, type.to_s.downcase) }

          it 'denies access' do
            call
            expect(response).to have_http_status(:forbidden)
          end

          it { expect { call }.to change { user.reload.failed_attempts }.by(1) }
        end
      end
    end
  end

  context 'without access token' do
    it_behaves_like 'response status', :unauthorized
  end

  context 'with incorrect access token' do
    let(:headers) { { 'Authorization' => 'Bearer wrong token' } }

    it { expect { call }.not_to change(JwtDenylist, :count) }

    it_behaves_like 'response status', :unauthorized
  end

  context 'with revoked access token' do
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }

    before { Warden::JWTAuth::TokenRevoker.new.call(access_token) }

    it { expect { call }.not_to change(JwtDenylist, :count) }

    it_behaves_like 'response status', :unauthorized
  end

  context 'with expired access token' do
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }
    let(:access_expire_at) { 1.second.ago.to_i }
    let(:access_token) { Warden::JWTAuth::TokenEncoder.new.call({ sub: user.id, scp: 'user', exp: access_expire_at }.with_indifferent_access) }

    it { expect { call }.not_to change(JwtDenylist, :count) }

    it_behaves_like 'response status', :unauthorized
  end

  context 'with correct refresh token used as authorization bearer' do
    let(:headers) { { 'Authorization' => "Bearer #{refresh_token}" } }
    let(:refresh_token) do
      Warden::JWTAuth::TokenEncoder.new.call({ sub: user.id, scp: 'refresh_token'}.with_indifferent_access)
    end

    it { expect { call }.not_to change(JwtDenylist, :count) }

    it_behaves_like 'response status', :unauthorized
  end

  context 'with access token from different secret' do
    let(:headers) { { 'Authorization' => "Bearer #{access_token}" } }
    let(:access_token) do
      JWT.encode({ sub: user.id, scp: 'user' }.with_indifferent_access, 'different secret', Warden::JWTAuth.config.algorithm)
    end

    it_behaves_like 'response status', :unauthorized
  end
end
