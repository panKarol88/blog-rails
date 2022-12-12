# frozen_string_literal: true

module ArticlesManagement
  module Index
    class GuestService < UserService
      private

      def query_params
        super.merge(published: true)
      end
    end
  end
end
