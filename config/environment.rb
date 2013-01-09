# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# Load the application config - reads from application.yml
require File.join(File.dirname(__FILE__), '../lib/application_config')
APPLICATION_CONFIG = ApplicationConfig.new

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on.
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "json"

  # Only load the plugins named here, in the order given. By default, all plugins
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/vendor/campaign-monitor-ruby/lib )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_webjam_session',
    :secret      => APPLICATION_CONFIG.session_secret || '390aee73c13cc70d55800f294844fad0ea969ec1b691f6c7183428c7a02b9c8a28b50c473dcd5f22f5f0fd2afc0efe1c05676edd8e487fada27a6169686ec0f9'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  config.active_record.observers = [:rsvp_observer, :presentation_proposal_observer, :jam_observer]
end

Time::DATE_FORMATS[:long_with_day_name] = "%A %B %e, %Y"
Time::DATE_FORMATS[:time_12hr] = "%I:%M%p"
Date::DATE_FORMATS[:long_with_day_name] = "%A %B %e, %Y"
Date::DATE_FORMATS[:dd] = "%d"
Date::DATE_FORMATS[:mon] = "%b"

# OpenID Gem should log to rails default logger
OpenID::Util.logger = RAILS_DEFAULT_LOGGER

ExceptionNotifier.exception_recipients = %w(t.lucas@toolmantim.com lachlan.hardy@gmail.com lstoll@lstoll.net dylan.fm@gmail.com)
ExceptionNotifier.sender_address = %("Application Error" <app.error@toolmantim.com>)
ExceptionNotifier.email_prefix = "[WEBCONSERVE] "

# we need to set the key as a constant first, so CM list works.
CAMPAIGN_MONITOR_API_KEY = APPLICATION_CONFIG.campaign_monitor_api_key

require 'core_ext/object'
