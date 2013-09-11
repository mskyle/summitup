class User < ActiveRecord::Base
  validates_presence_of :user_name
  validates_presence_of :email

  has_many :trips, through: :trip_participations
end
