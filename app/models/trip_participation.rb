class TripParticipation < ActiveRecord::Base

  validates_presence_of :user
  # validates_numericality_of :user_id, only_integer: true

  validates_presence_of :trip
  # validates_numericality_of :trip_id, only_integer: true

  belongs_to :user, inverse_of: :trip_participations

  belongs_to :trip, inverse_of: :trip_participations
end
