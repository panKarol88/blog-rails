# frozen_string_literal: true

# :reek:DuplicateMethodCall
module Searching
  class PaginationHandler < BaseHandler
    def apply(search_result)
      total_count = search_result.collection.count
      metadata = { current_page: page, per_page:, total_count:, total_pages: total_pages(total_count) }

      new_result(
        search_result.collection.page(page).per(per_page),
        search_result.metadata.merge(metadata)
      )
    end

    private

    def page
      @params[:page] || 1
    end

    def per_page
      @params[:per_page] || 25
    end

    def total_pages(total_count)
      (total_count / per_page).to_i + ((total_count % per_page).zero? ? 0 : 1)
    end
  end
end
