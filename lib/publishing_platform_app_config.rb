require "publishing_platform_app_config/version"
require "publishing_platform_app_config/publishing_platform_error"

if defined?(Rails)
  require "publishing_platform_app_config/publishing_platform_content_security_policy"
  require "publishing_platform_app_config/railtie"
end
