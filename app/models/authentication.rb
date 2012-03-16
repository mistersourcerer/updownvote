class Authentication < ActiveRecord::Base
  belongs_to :user

  serialize :data
end
