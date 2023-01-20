# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class Update < Base
          route_param :id, type: String do
            desc 'Update article',
                 headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
                 success: {
                   code: 200,
                   message: 'Article Updated'
                 },
                 failure: [
                   { code: 400, message: 'Bad request' },
                   { code: 404, message: 'Not found' },
                   { code: 401, message: 'Unauthorized' }
                 ]

            helpers Params

            params do
              use :article
            end

            helpers do
              def article
                @article ||= Article.find(params[:id])
              end

              def article_params
                declared(params.except(:id), include_missing: false)
              end
            end

            put do
              article.assign_attributes(article_params)
              article.save!

              status :ok
              ShowSerializer.render_as_json(article)
            end
          end
        end
      end
    end
  end
end
