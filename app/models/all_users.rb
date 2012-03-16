class AllUsers

  def initialize(user_finder = User, user_store = nil)
    @finder = user_finder
    @store = user_store
  end

  def find_or_initialize_by_email(email)
    @finder.find_or_initialize_by_email(email)
  end

  def add_or_update(user)
    store_for(user).save
  end

  private
  def store_for(storable)
    @store || storable
  end

end
