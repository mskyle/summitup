class TripParticipation < ActiveRecord::Base

  validates_presence_of :user_id
  validates_numericality_of :user_id, only_integer: true

  validates_presence_of :trip_id
  validates_numericality_of :trip_id, only_integer: true

  belongs_to :user
  belongs_to :trip 
end
