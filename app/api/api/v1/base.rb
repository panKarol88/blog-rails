# frozen_string_literal: true

module Api
  module V1
    class Base < Root
      version 'v1', using: :path
      format :json
      prefix :api
      default_error_formatter :json

      before do
        authenticate_user! unless skip_authentication?
      end

      rescue_from :all do |exception|
        handle_exception(exception)
      end

      helpers ::Helpers::Auth
      helpers ::Helpers::ErrorHandler
      helpers ::Grape::DSL::InsideRoute::PostBeforeFilter

      mount Api::V1::Users::Base
    end
  end
end
