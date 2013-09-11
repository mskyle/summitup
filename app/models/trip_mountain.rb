class TripMountain < ActiveRecord::Base
  validates_presence_of :mountain 
  validates_presence_of :trip 

  belongs_to :mountain
  belongs_to :trip
end
