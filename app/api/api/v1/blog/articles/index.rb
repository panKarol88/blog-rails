# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class Index < Base
          desc 'List articles',
               headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
               success: {
                 code: 200,
                 message: 'Articles []'
               },
               failure: [
                 { code: 401, message: 'Unauthorized' }
               ]

          helpers ::Helpers::PaginationParams

          helpers do
            def assessments_scope
              return Article.for_types('public') unless current_user.admin?

              Article.for_types(declared(params, include_missing: false)[:article_type])
            end

            def searching_result
              @searching_result ||= ::Searching::HandlingChain.new(params).process(assessments_scope)
            end
          end

          params do
            use :pagination
            optional :article_type, type: String, desc: 'Article type', default: 'public'
          end

          get do
            articles = searching_result.collection

            status :ok
            IndexSerializer.render_as_json(
              articles,
              root: :records,
              meta: searching_result.metadata
            )
          end
        end
      end
    end
  end
end
