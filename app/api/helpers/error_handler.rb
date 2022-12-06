# frozen_string_literal: true

module Helpers
  module ErrorHandler
    def handle_exception(exception)
      Rails.logger.error(exception.message)
      error_attributes = ApiManagement::ErrorHandlerService.new(exception:).error_attributes

      error!(error_attributes[:payload], error_attributes[:error_status])
    end

    def raise_api_error!(message, status)
      raise ApiManagement::Exceptions::ApiStandardError.new(status:, message:)
    end
  end
end
