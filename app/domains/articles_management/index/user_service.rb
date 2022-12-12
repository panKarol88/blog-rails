# frozen_string_literal: true

module ArticlesManagement
  module Index
    class UserService
      EXPECTED_PARAMS = %i[published worth_reading].freeze

      def initialize(**args)
        @request_params = args
      end

      def articles
        raise SystemManagement::ServiceExceptions::AbstractMethodCalled if instance_of?(UserService)

        Article.where(query_params)
      end

      private

      attr_reader :request_params

      def query_params
        request_params.slice(*EXPECTED_PARAMS)
      end
    end
  end
end
