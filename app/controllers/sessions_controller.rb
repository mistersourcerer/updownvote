class SessionsController < ApplicationController

  def create
    authenticator.authenticate
    if current_user
      redirect_to projects_path
    else
      redirect_to root_path
    end
  end

end
