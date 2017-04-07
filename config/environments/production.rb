Rails.application.configure do

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true
  config.cache_store = :memory_store, { size: 256.megabytes }
  # Do not eager load code on boot.
  config.eager_load = true
  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false


  config.log_level = :info

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end


  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  #config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.action_controller.perform_caching = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load
  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  ########################################################################
  # Assets
  ########################################################################
  config.assets.compile = true
  config.assets.precompile += %w( *.js ^[^_]*.css *.css.erb )
  config.serve_static_assets = true


  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Suppress logger output for asset requests.
  config.assets.quiet = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  #root :to => "home#index"
  ########################################################################
  # Action Mailer
  ########################################################################

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { :host => 'utms.cleartranscripts.com' }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address              => 'email-smtp.us-west-2.amazonaws.com',
      :port                 => 25,
      :enable_starttls_auto => true,
      :domain               => 'cleartranscripts.com',
      :user_name            => 'AKIAI7R36NNGR2URVQWA',
      :password             => 'AlLc0NkOmUpYu0lkJmqym6Z74mMFulwcbF+DVW0yvuHs',
      :authentication       => :login
  }

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker


  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true



  config.after_initialize do
  #   ActiveMerchant::Billing::Base.mode = :production
  #   paypal_options = {
  #     :login => "seller_1229899173_biz_api1.railscasts.com",
  #     :password => "FXWU58S7KXFC6HBE",
  #     :signature => "AGjv6SW.mTiKxtkm6L9DcSUCUgePAUDQ3L-kTdszkPG8mRfjaRZDYtSu"
  #   }
  #   ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end
end
