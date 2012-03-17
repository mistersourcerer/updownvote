class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def auth
    @authenticator ||= Authenticator.new(session, request.env["omniauth.auth"])
  end

  def current_user
    auth.current :user
  end

  private

  def self.protect_from_unauthorized(options={})
    before_filter :check_authorization, options
  end

  def check_authorization
    unless current_user
      redirect_to root_path
    end
  end

end
