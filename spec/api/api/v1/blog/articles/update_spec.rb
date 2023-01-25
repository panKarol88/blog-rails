# frozen_string_literal: true

describe Api::V1::Blog::Articles::Update, type: :request do
  describe 'PUT /api/v1/blog/articles/:id' do
    subject(:call) { put "/api/v1/blog/articles/#{article_id}", headers:, params: }

    let(:article) { create(:article) }
    let(:article_id) { article.id }
    let(:params) { {} }

    it_behaves_like 'secured endpoint', method: :put, url: '/api/v1/blog/articles/111111', allowed_types: ['Admin']

    describe 'authorized as admin', :authorized do
      let(:authenticated_user) { admin }
      let(:admin) { build(:user, :admin) }

      context 'when no params were given' do
        let(:expected_response_body) { Api::V1::Blog::Articles::ShowSerializer.render_as_json(Article.find(article_id)).to_json }

        it_behaves_like 'response status with body', :ok
      end

      context 'when params were given' do
        let(:params) { { label: 'New label' } }
        let(:expected_response_body) { Api::V1::Blog::Articles::ShowSerializer.render_as_json(Article.find(article_id)).to_json }

        it { expect { call }.to change { Article.find(article_id).label }.to('New label') }

        it_behaves_like 'response status with body', :ok
      end
    end
  end
end
