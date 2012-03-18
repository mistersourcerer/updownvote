class AllUsers

  def initialize(user_finder = User, user_store = nil)
    @finder = user_finder
    @store = user_store
  end

  def find_or_create_by_email(email)
    @finder.find_or_create_by_email(email)
  end

  def add_or_update(user)
    user.save
  end

end
