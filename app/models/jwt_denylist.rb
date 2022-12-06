# frozen_string_literal: true

class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'jwt_denylist'

  def self.revoke_jwt(payload, _user)
    exp = Time.zone.at(payload['exp'].to_i)
    refresh_token_jti = payload['refresh_token_jti']

    find_or_create_by!(jti: refresh_token_jti, exp:) if refresh_token_jti
    find_or_create_by!(jti: payload['jti'], exp:)
  end
end
