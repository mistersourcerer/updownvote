class Authenticator

  def initialize(
        session_store,
        auth_info,
        all_authentications = AllAuthentications.new,
        all_users = AllUsers.new)
    @info       = auth_info
    @session    = session_store
    @all_auths  = all_authentications
    @all_users  = all_users
  end

  def authenticate
    return false unless @info

    @session[:user] = user_for_info(@info)

    true
  end

  def current(key)
    @session[key]
  end

  private
  def user_for_info(info)
    user = @all_users.find_or_initialize_by_email(@info["info"] && @info["info"]["email"])
    auth = @all_auths.find_or_initialize_by_uid(@info["uid"])
    user.add_authentication auth

    @all_users.add_or_update(user)

    user
  end

end
