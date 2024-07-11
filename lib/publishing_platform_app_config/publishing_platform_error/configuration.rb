require "delegate"

module PublishingPlatformError
  class Configuration < SimpleDelegator
    def initialize(_sentry_configuration)
      super
      set_up_defaults
    end

    def set_up_defaults
      self.excluded_exceptions = [
        # Default ActionDispatch rescue responses
        "ActionController::RoutingError",
        "AbstractController::ActionNotFound",
        "ActionController::MethodNotAllowed",
        "ActionController::UnknownHttpMethod",
        "ActionController::NotImplemented",
        "ActionController::UnknownFormat",
        "Mime::Type::InvalidMimeType",
        "ActionController::MissingExactTemplate",
        "ActionController::InvalidAuthenticityToken",
        "ActionController::InvalidCrossOriginRequest",
        "ActionDispatch::Http::Parameters::ParseError",
        "ActionController::BadRequest",
        "ActionController::ParameterMissing",
        "Rack::QueryParser::ParameterTypeError",
        "Rack::QueryParser::InvalidParameterError",
        # Default ActiveRecord rescue responses
        "ActiveRecord::RecordNotFound",
        "ActiveRecord::StaleObjectError",
        "ActiveRecord::RecordInvalid",
        "ActiveRecord::RecordNotSaved",
        # Additional items
        "ActiveJob::DeserializationError",
        "CGI::Session::CookieStore::TamperedWithCookie",
        # TODO
        # "GdsApi::HTTPIntermittentServerError",
        # "GdsApi::TimedOutException",
        "PublishingPlatform::SSO::PermissionDeniedError",
        "Mongoid::Errors::DocumentNotFound",
        "Puma::HttpParserError",
        "Sinatra::NotFound",
        "Slimmer::IntermittentRetrievalError",
        "Slimmer::SourceWrapperNotFoundError",
        "Sidekiq::JobRetry::Skip",
        "SignalException",
      ]

      # This will exclude exceptions that are triggered by one of the ignored
      # exceptions. For example, when any exception occurs in a template,
      # Rails will raise a ActionView::Template::Error, instead of the original error.
      self.inspect_exception_causes_for_exclusion = true

      # Avoid "Sending envelope with items ... to Sentry" logspew, since we
      # don't use Sentry's automatic session tracking.
      self.auto_session_tracking = false
    end
  end
end
