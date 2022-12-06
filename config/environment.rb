# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
  config.session_store :disabled
end

Warden::JWTAuth.configure do |config|
  config.mappings = { user: User, refresh_token: User }
  config.revocation_strategies[:refresh_token] = JwtDenylist
end

# https://github.com/fxn/zeitwerk/issues/232
# eager_load only models dir to be able to call #subclasses on User model
Rails.autoloaders.main.eager_load_dir("#{Rails.root}/app/models")
