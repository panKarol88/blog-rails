# frozen_string_literal: true

# :reek:DuplicateMethodCall
module Searching
  class SearchHandler < BaseHandler
    def apply(search_result)
      return search_result if @params[:search_term].blank?

      new_result(
        search_result.collection.search(@params[:search_term]),
        search_result.metadata
      )
    end
  end
end
