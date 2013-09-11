class Trip < ActiveRecord::Base
  
  # has_many(:mountains)
  #   through: :trip_mountains
  # has_many(:comments)
  # has_many(:hikers)
  #   through: :trip_participations

  validates_presence_of :title
  validates_presence_of :date

  today = PartialDate::Date.new { |d| d.year = Date.today.year; d.month = Date.today.month; d.day = Date.today.day}
  earliest_allowable_date = today.value - 1000000
  latest_allowable_date = today.value + 50000
  binding.pry
  validates_inclusion_of :date, :within => earliest_allowable_date..latest_allowable_date
end
