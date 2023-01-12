# frozen_string_literal: true

describe Api::V1::Users::Me, type: :request do
  describe 'GET /api/v1/users/me' do
    subject(:call) { get '/api/v1/users/me', headers: }

    let(:authenticated_user) { create(:user, :admin) }

    it_behaves_like 'secured endpoint', method: :get, url: '/api/v1/users/me'

    describe 'successes', :authorized do
      context 'with correct access token' do
        let(:expected_response_body) { authenticated_user.slice(:id, :email, :nickname, :type).to_json }

        it_behaves_like 'response status with body', :ok
      end
    end
  end
end
