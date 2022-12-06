# frozen_string_literal: true

module ApiManagement
  module Exceptions
    class ApiStandardError < StandardError
      attr_reader :status, :message

      def initialize(status:, message:)
        @status = status
        @message = message

        super
      end
    end
  end
end
