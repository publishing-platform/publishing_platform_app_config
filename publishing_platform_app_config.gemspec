# frozen_string_literal: true

require_relative "lib/publishing_platform_app_config/version"

Gem::Specification.new do |spec|
  spec.name = "publishing_platform_app_config"
  spec.version = PublishingPlatformAppConfig::VERSION
  spec.authors = ["Publishing Platform"]

  spec.summary = "Base configuration for Publishing Platform applications"
  spec.description = "Base configuration for Publishing Platform applications"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.files =  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency "puma", ">= 5.6", "< 7.0"
  spec.add_dependency "sentry-rails", "~> 5.3"
  spec.add_dependency "sentry-ruby", ">= 5.3", "< 7.0"

  spec.add_development_dependency "climate_control"
  spec.add_development_dependency "publishing_platform_rubocop"
  spec.add_development_dependency "rails", "~> 7"
  spec.add_development_dependency "simplecov"
end
