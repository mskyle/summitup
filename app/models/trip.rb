class Trip < ActiveRecord::Base
  
  # has_many(:mountains)
  #   through: :trip_mountains
  # has_many(:comments)
  # has_many(:hikers)
  #   through: :trip_participations
  has_many :trip_mountains

  has_many :mountains, through: :trip_mountains

  validates_presence_of :title
  validates_presence_of :date

end
