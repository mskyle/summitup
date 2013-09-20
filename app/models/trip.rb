class Trip < ActiveRecord::Base
  
  has_many :trip_participations,
   inverse_of: :trip
  
  has_many :users, 
    through: :trip_participations


  # the order here matters!!
  has_many :trip_mountains, 
    inverse_of: :trip 
  has_many :mountains, 
    through: :trip_mountains, 
      inverse_of: :trips 
  # has_many :mountains, through: :trip_mountains, inverse_of: :trips
  # has_many :trip_mountains, inverse_of: :trip

  validates_presence_of :title
  validates_presence_of :date

end
