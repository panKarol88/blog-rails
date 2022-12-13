# frozen_string_literal: true

describe Api::V1::Blog::Articles::Index, type: :request do
  describe 'GET /api/v1/blog/articles' do
    subject(:call) { get '/api/v1/blog/articles', headers:, params: }

    let(:params) { {} }

    before do
      create(:article, :published, :worth_reading, label: 'Aaaa', description: 'oo')
      create(:article, :published, :worth_reading, label: 'Zzzz', description: 'ss')
      create(:article, :published, label: 'Bbbb', description: 'aa')
      create(:article, :worth_reading, label: 'Cccc', description: 'bb')
    end

    describe 'not authorized calls' do
      context 'when no params were given' do
        let(:expected_response_ids) { Article.published.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when default params were given' do
        let(:params) { { worth_reading: true, published: true } }
        let(:expected_response_ids) { Article.published.worth_reading.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when published: false and worth_reading: true was given' do
        let(:params) { { worth_reading: true, published: false } }
        let(:expected_response_ids) { Article.published.worth_reading.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when published: true and worth_reading: false was given' do
        let(:params) { { worth_reading: false, published: true } }
        let(:expected_response_ids) { Article.published.worth_reading(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when published: false and worth_reading: false was given' do
        let(:params) { { worth_reading: false, published: false } }
        let(:expected_response_ids) { Article.published.worth_reading(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only published: true was given' do
        let(:params) { { published: true } }
        let(:expected_response_ids) { Article.published.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only published: false was given' do
        let(:params) { { published: false } }
        let(:expected_response_ids) { Article.published.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only worth_reading: true was given' do
        let(:params) { { worth_reading: true } }
        let(:expected_response_ids) { Article.published.worth_reading.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only worth_reading: false was given' do
        let(:params) { { worth_reading: false } }
        let(:expected_response_ids) { Article.published.worth_reading(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when search was given' do
        let(:params) { { search_term: 'aaa' } }
        let(:expected_response_ids) { Article.published.worth_reading.where(label: 'Aaaa').ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when sort was given' do
        let(:params) { { sort: ['articles.label'] } }
        let(:expected_response_ids) { Article.published.order(label: :asc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when pagination params were given' do
        let(:params) { { page: 1, per_page: 2 } }
        let(:expected_response_ids) { Article.published.order(created_at: :desc).page(1).per(2).ids }

        it_behaves_like 'response status with index ids', :ok
      end
    end

    describe 'authorized as admin', :authorized do
      let(:authenticated_user) { admin }
      let(:admin) { build(:user, :admin) }

      context 'when no params were given' do
        let(:expected_response_ids) { Article.all.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when default params were given' do
        let(:params) { { worth_reading: true, published: true } }
        let(:expected_response_ids) { Article.published.worth_reading.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when published: false and worth_reading: true was given' do
        let(:params) { { worth_reading: true, published: false } }
        let(:expected_response_ids) { Article.published(false).worth_reading.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when published: true and worth_reading: false was given' do
        let(:params) { { worth_reading: false, published: true } }
        let(:expected_response_ids) { Article.published.worth_reading(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when published: false and worth_reading: false was given' do
        let(:params) { { worth_reading: false, published: false } }
        let(:expected_response_ids) { Article.published(false).worth_reading(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only published: true was given' do
        let(:params) { { published: true } }
        let(:expected_response_ids) { Article.published.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only published: false was given' do
        let(:params) { { published: false } }
        let(:expected_response_ids) { Article.published(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only worth_reading: true was given' do
        let(:params) { { worth_reading: true } }
        let(:expected_response_ids) { Article.worth_reading.order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end

      context 'when only worth_reading: false was given' do
        let(:params) { { worth_reading: false } }
        let(:expected_response_ids) { Article.worth_reading(false).order(created_at: :desc).ids }

        it_behaves_like 'response status with index ids', :ok
      end
    end
  end
end
