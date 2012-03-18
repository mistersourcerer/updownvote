class Authenticator

  def initialize(
        session_store,
        auth_info,
        all_users = AllUsers.new)
    @info       = auth_info
    @session    = session_store
    @all_users  = all_users
  end

  def authenticate
    return false unless @info

    user = user_for_info(@info)
    @all_users.add_or_update(user)
    @session[:user] = user

    true
  end

  def current(key)
    @session[key]
  end

  def new_authentication_with_info(auth_info)
    Authentication.new(
      uid:  auth_info["uid"],
      data: auth_info["info"].merge(auth_info["extra"])
    )
  end

  private
  def user_for_info(info)
    user = @all_users.find_or_create_by_email(@info["info"] && @info["info"]["email"])
    user.add_authentication new_authentication_with_info(@info)

    nome = @info["info"] && @info["info"]["name"]
    if user.nome != nome
      user.nome = nome
    end

    user
  end

end
