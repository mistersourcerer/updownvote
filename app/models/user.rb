class User < ActiveRecord::Base
  has_many :authentications
  private :authentications=

  def add_authentication(authentication)
    unless authentication.user == self
      authentication.user = self
    end
    merge_authentication(authentication)
  end

  private
  def merge_authentication(authentication)
    existent_auth = authentications.select{ |a| a.uid == authentication.uid }.first
    if existent_auth && (existent_auth.data != authentication.data)
      existent_auth.data = authentication.data
    else
      authentications << authentication
    end
  end
end
