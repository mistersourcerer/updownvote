class Authenticator

  def initialize(
        auth_info,
        session_store,
        all_authentications = AllAuthentications.new,
        all_users = AllUsers.new)
    @info = auth_info
    @session = session_store
    @all_auths = all_authentications
    @all_users = all_users
  end

  def authenticate
    auth = @all_auths.find_or_initialize_by_uid @info["uid"]
    user = @all_users.find_or_initialize_by_email @info["info"]["email"]
    user.add_authentication auth
    @session[:user] = user
  end

  def current(key)
    @session[key]
  end

end
