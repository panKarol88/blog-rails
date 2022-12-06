# frozen_string_literal: true

module Api
  module V1
    module Users
      class SignOut < Base
        resource :sign_out do
          desc 'Sign out',
               headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
               success: {
                 code: 200, message: 'User signed out successfully'
               },
               failure: [
                 { code: 400, message: 'Bad request' },
                 { code: 401, message: 'Unauthorized' },
                 { code: 422, message: 'Unprocessable entity' }
               ]

          delete do
            Warden::JWTAuth::TokenRevoker.new.call(token)

            status :ok
            { message: 'User signed out successfully' }
          end
        end
      end
    end
  end
end
