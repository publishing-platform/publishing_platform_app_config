require "sentry-ruby"
require "sentry-rails" if defined?(Rails)
require "publishing_platform_app_config/publishing_platform_error/configuration"
require "publishing_platform_app_config/version"

module PublishingPlatformError
  class AlreadyInitialised < StandardError
    def initialize(msg = "You can only call PublishingPlatformError.configure once!")
      super
    end
  end

  def self.notify(exception_or_message, args = {})
    # Allow users to use `parameters` as a key like the Airbrake
    # client, allowing easy upgrades.
    args[:extra] ||= {}
    args[:extra].merge!(parameters: args.delete(:parameters))

    args[:tags] ||= {}
    args[:tags][:publishing_platform_app_config_version] = PublishingPlatformAppConfig::VERSION

    if exception_or_message.is_a?(String)
      Sentry.capture_message(exception_or_message, **args)
    else
      Sentry.capture_exception(exception_or_message, **args)
    end
  end

  def self.is_configured?
    Sentry.get_current_client != nil
  end

  def self.configure
    raise PublishingPlatformError::AlreadyInitialised if is_configured?

    if defined?(Sidekiq) && !defined?(Sentry::Sidekiq)
      warn "Warning: PublishingPlatformError is not configured to track Sidekiq errors, install the sentry-sidekiq gem to track them."
    end

    Sentry.init do |sentry_config|
      config = Configuration.new(sentry_config)
      yield config if block_given?
    end
  end
end
