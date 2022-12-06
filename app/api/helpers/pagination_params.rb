# frozen_string_literal: true

module Helpers
  module PaginationParams
    extend Grape::API::Helpers

    params :pagination do
      optional :page, type: Integer, default: 1
      optional :per_page, type: Integer, default: 25
      optional :search_term, type: String
      optional :sort, type: Array, default: ['-updated_at']
    end
  end
end
