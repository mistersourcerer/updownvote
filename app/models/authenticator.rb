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

    user = user_for_info(@info)
    @all_users.add_or_update(user)
    @session[:user] = user

    true
  end

  def current(key)
    @session[key]
  end

  private
  def auth_for_info(info)
    auth = @all_auths.find_or_initialize_by_uid(@info["uid"])

    data = @info["extra"] || {}
    if auth.data != data
      auth.data = data
    end

    auth
  end

  def user_for_info(info)
    user = @all_users.find_or_initialize_by_email(@info["info"] && @info["info"]["email"])
    user.add_authentication auth_for_info(@info)

    nome = @info["info"] && @info["info"]["name"]
    if user.nome != nome
      user.nome = nome
    end

    user
  end

end
