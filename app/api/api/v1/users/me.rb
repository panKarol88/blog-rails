# frozen_string_literal: true

module Api
  module V1
    module Users
      class Me < Base
        resource :me do
          desc 'Me',
               headers: ::SwaggerHelpers::Requests::STANDARD_HEADERS,
               success: {
                 code: 200, message: 'User info'
               },
               failure: [
                 { code: 400, message: 'Bad request' },
                 { code: 401, message: 'Unauthorized' },
                 { code: 422, message: 'Unprocessable entity' }
               ]

          get do
            status :ok
            Api::V1::Users::MeSerializer.render_as_json(current_user)
          end
        end
      end
    end
  end
end
