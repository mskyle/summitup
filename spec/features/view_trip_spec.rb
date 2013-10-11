require 'spec_helper'

feature 'a user views a hike', %q{
  As a user
  I want to view the record of a hike
  So that I can see what it was like
  } do
  # Acceptance Criteria:
  # * I can see the stored information about the hike
  let(:user) { FactoryGirl.create(:user) }
  let(:mountain) { FactoryGirl.create(:mountain) }
  let(:trip) { FactoryGirl.create(:trip, users: [user], mountains: [mountain]) }

  scenario 'a user views a hike' do 
    visit trip_path(trip)
    expect(page).to have_content(trip.date, trip.title, trip.distance, trip.users.first, trip.mountains.first)
  end
end
