# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class Create < Base
          desc 'Create article',
               headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
               success: {
                 code: 200,
                 message: 'Article Created'
               },
               failure: [
                 { code: 400, message: 'Bad request' },
                 { code: 401, message: 'Unauthorized' }
               ]

          helpers Params

          params do
            use :article
          end

          helpers do
            def article
              @article ||= Article.new
            end

            def article_params
              declared(params.except(:id), include_missing: false)
            end
          end

          post do
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
