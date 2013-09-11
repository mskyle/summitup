class TripMountain < ActiveRecord::Base
  validates_presence_of :mountain_id
  validates_presence_of :trip_id

  belongs_to :mountain
  belongs_to :trip
end
