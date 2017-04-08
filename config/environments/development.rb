Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_dispatch.tld_length = 0

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_url = "http://9cbe4d2c.ngrok.io/ccavRequestHandler"
  config.redirect_url = "http://9cbe4d2c.ngrok.io/ccavResponseHandler"
  config.cancel_url = "http://9cbe4d2c.ngrok.io/ccavResponseHandler"

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Mailer settings
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

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    paypal_options = {
      :login => "himanshu-facilitator_api1.cleartranscripts.com",
      :password => "F2HF6JFMSPE8H46V",
      :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31ADIDczXSEXuqAYYI9K5rrQbA-S0S"
    }
    # ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end