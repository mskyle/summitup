class User < ActiveRecord::Base
  validates_presence_of :user_name
  validates_presence_of :email

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  has_many :trips, through: :trip_participations
  has_many :mountains, through: :trips
end
