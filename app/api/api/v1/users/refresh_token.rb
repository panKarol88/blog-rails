# frozen_string_literal: true

module Api
  module V1
    module Users
      class RefreshToken < Base
        route_setting :auth, disabled: true
        resource :refresh_token do
          desc 'Refresh access token',
               success: {
                 code: 200, message: '{ access_token: jwt_token}'
               },
               failure: [
                 { code: 400, message: 'Bad request' },
                 { code: 401, message: 'Unauthorized' },
                 { code: 422, message: 'Unprocessable entity' }
               ]

          params do
            requires :refresh_token, type: String, desc: 'Refresh token'
          end

          before do
            env['HTTP_AUTHORIZATION'] = "Bearer #{params[:refresh_token]}"
          end

          post do
            raise unauthorized_error! unless user_from_refresh_token

            status :ok
            { access_token: access_token(linked_refresh_token: token, sub: user_from_refresh_token.id) }
          end
        end
      end
    end
  end
end
