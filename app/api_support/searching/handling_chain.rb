# frozen_string_literal: true

module Searching
  class HandlingChain
    AVAILABLE_HANDLER_CLASSES = {
      search_term: SearchHandler,
      sort: SortingHandler,
      page: PaginationHandler
    }.freeze

    def initialize(params)
      @params = params.symbolize_keys
      @handlers = build_handlers
    end

    def process(record_scope)
      searching_result = Result.new(record_scope)
      return searching_result if @handlers.empty?

      @handlers.each do |handler|
        searching_result = handler.apply(searching_result)
      end

      searching_result
    end

    private

    def build_handlers
      handlers = []
      @params.slice(:search_term, :sort, :page).each_key do |param_name|
        handlers.append(build_handler(param_name))
      end
      handlers
    end

    def build_handler(param_name)
      AVAILABLE_HANDLER_CLASSES[param_name].new(@params)
    end
  end
end
