# frozen_string_literal: true

module Searching
  class Result
    attr_reader :collection, :metadata

    def initialize(collection, metadata = {})
      @collection = collection
      @metadata = metadata
    end
  end
end
