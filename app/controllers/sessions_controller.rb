class SessionsController < ApplicationController

  def create
    session.clear
    auth.authenticate

    if current_user
      redirect_to projects_path
    else
      redirect_to root_path
    end
  end

end
