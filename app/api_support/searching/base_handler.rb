# frozen_string_literal: true

module Searching
  class BaseHandler
    def initialize(params)
      @params = params
    end

    # Override this method
    def apply(_search_result)
      Result.new(nil, {})
    end

    private

    def new_result(collection, options)
      Result.new(collection, options)
    end
  end
end
