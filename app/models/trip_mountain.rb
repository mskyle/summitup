class TripMountain < ActiveRecord::Base
  validates_presence_of :mountain
  validates_presence_of :trip

  #belongs_to :mountain, inverse_of: :trip_mountains
  #belongs_to :trip, inverse_of: :trip_mountains

  belongs_to :trip,
    inverse_of: :trip_mountains
  belongs_to :mountain, 
    inverse_of: :trip_mountains 
end
