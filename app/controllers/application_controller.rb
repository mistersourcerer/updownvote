class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def self.uses_authenticator(method_name = :auth)
    define_method method_name do
      @authenticator ||= Authenticator.new(session, request.env["omniauth.auth"])
    end
  end

  def authenticator
    @authenticator ||= Authenticator.new(session, request.env["omniauth.auth"])
  end

  def current_user
    authenticator.current :user
  end
end
