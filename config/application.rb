require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'rack'
require 'rack/cors'

Bundler.require(*Rails.groups)

module PWebApp
  class Application < Rails::Application
    config.hostname                          = ENV.fetch('HOSTNAME', 'example.com')
    config.action_mailer.default_url_options = { host: config.hostname }

    config.i18n.load_path                    += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales            = [:en, :pl]
    config.i18n.enforce_available_locales    = true
    config.i18n.default_locale               = :pl

    config.assets.paths << "#{Rails}/vendor/assets/fonts"

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
