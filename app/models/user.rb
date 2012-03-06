class User
  attr_accessor :email

  def initialize(attrs)
    attrs.each_pair do |name, value|
      send("#{name}=", value)
    end
  end
end
