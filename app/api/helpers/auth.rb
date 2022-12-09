# frozen_string_literal: true

module Helpers
  module Auth
    def token
      auth_token = request.headers['Authorization']
      auth_token.split.last if auth_token.present?
    end

    def authenticate_user!
      raise unauthorized_error! unless current_user
    end

    def current_user
      return @current_user if defined?(@current_user)

      @current_user ||= determine_current_user
    end

    def determine_current_user
      return user_from_token if authentication_required?

      user_from_token || Guest.new
    end

    def user_from_token
      warden.authenticate(:jwt, scope: :user, run_callbacks: false)
    end

    def user_from_refresh_token
      warden.authenticate(:jwt, scope: :refresh_token, run_callbacks: false)
    end

    def access_token(linked_refresh_token: refresh_token, sub: current_user.id)
      payload = {
        sub:,
        scp: 'user',
        refresh_token_jti: Warden::JWTAuth::TokenDecoder.new.call(linked_refresh_token)['jti'],
        email: current_user.email,
        nickname: current_user.nickname
      }.with_indifferent_access

      Warden::JWTAuth::TokenEncoder.new.call(payload)
    end

    def refresh_token(sub: current_user.id)
      @refresh_token ||= begin
        payload = {
          sub:,
          scp: 'refresh_token',
          exp: ENV.fetch('DEVISE_REFRESH_JWT_EXPIRATION_TIME',
                         Warden::JWTAuth.config.expiration_time).to_i.seconds.from_now.to_i
        }.with_indifferent_access
        Warden::JWTAuth::TokenEncoder.new.call(payload)
      end
    end

    def warden
      request.env['warden']
    end

    def aud
      Warden::JWTAuth::EnvHelper.aud_header(env)
    end

    def unauthorized_error!
      raise_api_error!('Unauthorized', :unauthorized)
    end

    def forbidden_error!
      increment_failed_attempts
      raise_api_error!('Forbidden', :forbidden)
    end

    def skip_authentication?
      route.settings&.dig(:auth, :disabled)
    end

    def authentication_required?
      !skip_authentication?
    end
  end
end
