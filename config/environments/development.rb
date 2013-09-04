TibiaSmuggler::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Set default URL base for mailers
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Set mailers to use GMail
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address              =>  'smtp.gmail.com',
      :port                 =>  587,
      :user_name            =>  'tibiasmuggler@gmail.com',
      :password             =>  ENV['GMAIL_PASSWORD'],
      :authentication       =>  'plain',
      :enable_starttls_auto =>  true  }

  # Deliver emails in development (edit: temporarily false!)
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # 4.0.0 requirement
  config.eager_load = false
end
