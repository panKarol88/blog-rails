# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class Show < Base
          route_param :id, type: String do
            desc 'Show article',
                 headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
                 success: {
                   code: 200,
                   message: 'Article'
                 },
                 failure: [
                   { code: 400, message: 'Bad request' },
                   { code: 401, message: 'Unauthorized' }
                 ]

            helpers do
              def article
                @article ||= Article.find(params[:id])
              end
            end

            get do
              status :ok
              ShowSerializer.render_as_json(article)
            end
          end
        end
      end
    end
  end
end
