# frozen_string_literal: true

describe Api::V1::Blog::Articles::Create, type: :request do
  describe 'POST /api/v1/blog/articles' do
    subject(:call) { post '/api/v1/blog/articles', headers:, params: }

    let(:params) { {} }

    it_behaves_like 'secured endpoint', method: :post, url: '/api/v1/blog/articles', allowed_types: ['Admin']

    describe 'authorized as admin', :authorized do
      let(:authenticated_user) { admin }
      let(:admin) { build(:user, :admin) }

      context 'when no params were given' do
        let(:expected_response_body) { Api::V1::Blog::Articles::ShowSerializer.render_as_json(Article.last).to_json }

        it_behaves_like 'response status with body', :ok
      end
    end
  end
end
