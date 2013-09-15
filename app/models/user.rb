class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :user_name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_uniqueness_of :user_name
  
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  has_many :trips, through: :trip_participations
  has_many :mountains, through: :trips

end
