class SessionsController < ApplicationController

  def create
    auth_info = OmniAuth::Info.new(request.env["omniauth.auth"])

    if auth_info.success?
      user = AllUsers.with_email auth_info.email
      session[:user] = user
      session[:auth_info] = {:provider => auth_info.provider, :uid => auth_info.uid}
    end

    redirect_to root_path
  end

end
