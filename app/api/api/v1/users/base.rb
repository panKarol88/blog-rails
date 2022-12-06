# frozen_string_literal: true

module Api
  module V1
    module Users
      class Base < Api::V1::Base
        resource :users do
          mount Api::V1::Users::SignIn
          mount Api::V1::Users::SignOut
          mount Api::V1::Users::RefreshToken
        end
      end
    end
  end
end
