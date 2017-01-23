require_relative 'boot'

require 'rails/all'

#
# require 'carrierwave'
# require 'carrierwave/orm/activerecord'
#

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RestEasy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << Rails.root.join('lib')

    config.middleware.use ActionDispatch::Flash
  end
end
