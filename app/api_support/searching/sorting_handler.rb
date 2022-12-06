# frozen_string_literal: true

module Searching
  class SortingHandler < BaseHandler
    def apply(search_result)
      return search_result if @params[:sort].blank?

      new_result(
        search_result.collection.order(SortingParams.new(@params).to_s),
        search_result.metadata
      )
    end

    class SortingParams
      DESC_PATTERN = /\A-/

      def initialize(params = {})
        @raw_sort = [params[:sort]].flatten
      end

      def to_s
        map_sort.join(',')
      end

      private

      def map_sort
        @raw_sort.map do |sort|
          "#{sort.sub(DESC_PATTERN, '')} #{DESC_PATTERN.match?(sort) ? 'DESC' : 'ASC'}"
        end
      end
    end
  end
end
