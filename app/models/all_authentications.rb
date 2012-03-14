class AllAuthentications

  def initialize(finder = Authentication)
    @finder = finder
  end

  def find_or_initialize_by_uid(uid)
    finder.find_or_initialize_by_uid uid
  end

end
