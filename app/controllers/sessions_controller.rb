class SessionsController < ApplicationController
  uses_authenticator
  uses_current_user

  def create
    auth.authenticate
    if current_user
      redirect_to projects_path
    else
      redirect_to root_path
    end
  end

end
