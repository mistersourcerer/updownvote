class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticator
    @authenticator ||= Authenticator.new(session, request.env["omniauth.auth"])
  end

  def current_user
    authenticator.current :user
  end
end
