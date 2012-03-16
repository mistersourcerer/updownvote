class User < ActiveRecord::Base
  has_many :authentications

  def add_authentication(authentication)
    authentication.user = self
    authentications << authentication
  end
end
