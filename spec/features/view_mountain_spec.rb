require 'spec_helper'

feature 'a user views a mountain', %Q{
  As a user
  I want to be able to see information about a mountain
  So that I can make informed hiking decisions
} do

  # Acceptance Criteria
  # * Whether I am logged in or not, I can see basic information about the mountain.
  # * If I am logged in and have hiked the mountain, I can see the hikes I did that included this mountain
  # * I don't see other hikes that I have done that did not included this mountain
  
  let (:mountain) { FactoryGirl.create(:mountain) }
  let (:user) { FactoryGirl.create(:user) }
  let (:trip) { FactoryGirl.create(:trip) }
  let (:trip_participation) { FactoryGirl.create(:trip_participation, trip_id: trip.id, user_id: user.id) }
  let (:trip_mountain) { FactoryGirl.create(:trip_mountain, trip_id: trip.id, mountain_id: mountain.id) }
  let (:admin) { FactoryGirl.build(:user, admin: true) }
  scenario 'visiting a mountain page when not logged in' do 
    visit mountain_path(mountain)
    expect(page).to have_content(mountain.name, mountain.height, mountain.notes, mountain.latitude, mountain.longitude)
  end

  scenario 'visiting a mountain page for a mountain current user has not hiked' do
    trip_mountain
    trip_participation
    mountain
    mountain2 = FactoryGirl.create(:mountain)

    visit root_path
    login_user(user)

    visit mountain_path(mountain2)
    expect(page).to have_content("hiked this mountain yet")
    expect(page).to have_no_content(user.trips.last.title)
  end

  scenario 'visiting a mountain page for a mountain current user has hiked' do
    trip_mountain
    trip_participation

    visit root_path
    login_user(user)

    mountain2 = FactoryGirl.create(:mountain)
    trip2 = FactoryGirl.create(:trip)
    trip_participation2 = FactoryGirl.create(:trip_participation, trip_id: trip2.id, user_id: user.id)
    trip_mountain2 = FactoryGirl.create(:trip_mountain, trip_id: trip2.id, mountain_id: mountain2.id)

    visit mountain_path(mountain)
    expect(page).to have_content(trip.title)
    expect(page).to have_no_content(trip2.title)
  end

  scenario 'there is a link to the mountain edit page for admins' do
    login_user(admin)
    visit mountain_path(mountain)    
    click_on "Edit this mountain"
    expect(page).to have_content("Edit mountain", "Image")
  end

end


