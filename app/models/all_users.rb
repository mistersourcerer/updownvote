class AllUsers

  def initialize(user_fetcher = User)
    @user_finder = user_fetcher
  end

  def find_or_initialize_by_email(email)
    @user_finder.find_or_initialize_by_email(email)
  end

end
