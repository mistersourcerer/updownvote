class User < ActiveRecord::Base
  has_many :authentications

  def add_authentication(authentication)
  end

end
