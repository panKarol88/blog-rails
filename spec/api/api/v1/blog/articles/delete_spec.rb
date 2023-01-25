# frozen_string_literal: true

describe Api::V1::Blog::Articles::Delete, type: :request do
  describe 'DELETE /api/v1/blog/articles/:id' do
    subject(:call) { delete "/api/v1/blog/articles/#{article_id}", headers:, params: }

    let(:article) { create(:article) }
    let(:article_id) { article.id }
    let(:params) { {} }

    it_behaves_like 'secured endpoint', method: :delete, url: '/api/v1/blog/articles/11111111', allowed_types: ['Admin']

    describe 'authorized as admin', :authorized do
      let(:authenticated_user) { admin }
      let(:admin) { build(:user, :admin) }

      context 'when no params were given' do
        let(:expected_response_body) { {} }

        it { expect { call }.to change(Article, :count).by(-1) }

        it_behaves_like 'response status with body', :ok
      end
    end
  end
end
