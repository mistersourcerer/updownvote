class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def check_authorization
    unless current_user
      redirect_to root_path
    end
  end

  def self.protect_from_unauthorized
    uses_current_user
    before_filter :check_authorization
  end

  def self.uses_authenticator(method_name = :auth)
    unless self.instance_methods.include? method_name
      define_method method_name do
        @authenticator ||= Authenticator.new(session, request.env["omniauth.auth"])
      end
    end
  end

  def self.uses_current_user
    unless self.instance_methods.include? :current_user
      uses_authenticator
      define_method :current_user do
        auth.current :user
      end
    end
  end
end
