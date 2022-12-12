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
                 { code: 400, message: 'Bad request' },
                 { code: 401, message: 'Unauthorized' }
               ]

          helpers ::Helpers::PaginationParams

          params do
            use :pagination
            optional :worth_reading, type: Boolean, desc: 'Should return only worth reading articles?'
            optional :published, type: Boolean, desc: 'Should return only published articles?'
          end

          helpers do
            def articles_scope
              "ArticlesManagement::Index::#{current_user.type}Service".constantize.new(**declared(params, include_missing: false)).articles
            end

            def searching_result
              @searching_result ||= ::Searching::HandlingChain.new(params).process(articles_scope)
            end
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
