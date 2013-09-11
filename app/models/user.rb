class User < ActiveRecord::Base
  validates_presence_of :user_name
  validates_presence_of :email

  inverse_of :hiker
end
