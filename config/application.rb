require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlogRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # raise Zeitwerk::NameError on heroku-22 - comment it out
    # config.load_defaults 6.1
    config.autoload = :classic
    config.api_only = true

    config.before_configuration do
      env_file = Rails.root.join('config', 'local_env.yml').to_s

      if File.exists?(env_file)
        YAML.safe_load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value.to_s
        end
      end
    end unless Rails.env.test?

    Rails.configuration.active_storage.draw_routes = false
  end
end
