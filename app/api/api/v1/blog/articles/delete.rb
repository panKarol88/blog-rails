# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class Delete < Base
          route_param :id, type: String do
            desc 'Delete article',
                 headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
                 success: {
                   code: 200,
                   message: 'Article Deleted'
                 },
                 failure: [
                   { code: 400, message: 'Bad request' },
                   { code: 404, message: 'Not found' },
                   { code: 401, message: 'Unauthorized' }
                 ]

            helpers do
              def article
                @article ||= Article.find(params[:id])
              end
            end

            delete do
              article.destroy!

              status :ok
              { message: 'Article Deleted' }
            end
          end
        end
      end
    end
  end
end
