class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def session_store
    Object.new.instance_eval {
      @session = session
      def []=(key, value)
        @session[key] = value
      end

      def [](key)
        @session[key]
      end
    }
  end

  def authenticator
    @authenticator ||= Authenticator.new(session_store, request.env["omniauth.auth"])
  end

  def current_user
    @authenticator.current :user
  end
end
