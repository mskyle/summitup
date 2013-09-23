require 'spec_helper' 

feature "date restrictions" %q{
  As a user
  I want to be stopped from entering in dates for hikes that are from, like, before I was born
  So that my hike record accurately reflects my personal hiking history
}

  # Acceptance criteria:
  # * when I input a hike, I can't input dates that are too early
  # * I cannot input dates that are too far in the future

  scenario 'I try to enter a date too far in the past' do 
    visit new_trip_path
  end
