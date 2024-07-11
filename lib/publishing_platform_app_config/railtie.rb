module PublishingPlatformAppConfig
  class Railtie < Rails::Railtie
    config.after_initialize do
      PublishingPlatformError.configure unless PublishingPlatformError.is_configured?
    end
  end
end
