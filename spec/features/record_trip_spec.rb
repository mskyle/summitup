require 'spec_helper'

feature 'a user records a hike', %q{
  As a signed-in user
  I want to create a record of a specific hike of a specific mountain
  So that I can later retrieve information about my hikes and the mountains I've summited
  } do
  # Acceptance Criteria:
  # * I can select a mountain from a list of mountains
  # * I can enter information about a hike of that mountain
  # * The information is saved so that it can be retrieved later
  # * I am automatically included as a hiker on the hike
  # * I can set privacy setting for the hike

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:trip) { FactoryGirl.create(:trip) }
  let!(:trip_participation) { FactoryGirl.create(:trip_participation, trip: trip, user: user) }

  scenario "filling out the form with minimum required attributes" do 
    prev_trip_count = Trip.count

    visit root_path
    login_user(user)  

    visit new_trip_path
    fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"

    click_on "Record Hike"
    expect(Trip.count).to eql(prev_trip_count + 1)
    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "filling out the form with all available fill-in attributes except mountain" do
    prev_trip_count = Trip.count
    prev_trip_mountain_count = TripMountain.count

    login_user(user)

    visit new_trip_path
    fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"
    fill_in "Notes", with: "It was pretty awesome!"
    fill_in "Trails", with: "Ammonusuc Ravine, Jewell"
    fill_in "Book time", with: "90"
    fill_in "Actual time", with: "80"
    fill_in "Distance", with: "4"
    fill_in "Difficulty", with: "4"
    fill_in "Awesomeness", with: "4"
    click_on "Record Hike"

    expect(Trip.count).to eql(prev_trip_count + 1)
    expect(TripMountain.count).to eql(prev_trip_mountain_count)

    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "filling out the form with insufficient attributes" do
    login_user(user) 

    prev_trip_count = Trip.count
    visit new_trip_path

    click_on "Record Hike"

    expect(page).to have_content "can't be blank"
    expect(Trip.count).to eql(prev_trip_count)

  end

  scenario "filling out the form with one mountain included" do
    mountain = FactoryGirl.create(:mountain)
    prev_trip_count = Trip.count
    prev_trip_mountain_count = TripMountain.count

    login_user(user)

    visit new_trip_path
    fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"
    fill_in "Notes", with: "It was pretty awesome!"
    select mountain.name, from: "Mountain"
    fill_in "Trails", with: "Ammonusuc Ravine, Jewell"
    fill_in "Book time", with: "90"
    fill_in "Actual time", with: "80"
    fill_in "Distance", with: "4"
    fill_in "Difficulty", with: "4"
    fill_in "Awesomeness", with: "4"
    click_on "Record Hike"

    expect(page).to have_content "Awesome! Your hike has been recorded."
    expect(Trip.count).to eql(prev_trip_count + 1)
    expect(TripMountain.count).to eql(prev_trip_mountain_count + 1)
  end

  scenario "filling out the form with multiple mountains included" do
    
    mountain = FactoryGirl.create(:mountain)
    mountain2 = FactoryGirl.create(:mountain)
    prev_trip_count = Trip.count
    prev_trip_mountain_count = TripMountain.count

    login_user(user)

    visit new_trip_path
    fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"
    fill_in "Notes", with: "It was pretty awesome!"
    select mountain.name, from: "Mountain"
    select mountain2.name, from: "Mountain"
    fill_in "Trails", with: "Ammonusuc Ravine, Jewell"
    fill_in "Book time", with: "90"
    fill_in "Actual time", with: "80"
    fill_in "Distance", with: "4"
    fill_in "Difficulty", with: "4"
    fill_in "Awesomeness", with: "4"
    click_on "Record Hike"

    expect(page).to have_content "Awesome! Your hike has been recorded."
    expect(Trip.count).to eql(prev_trip_count + 1)
    expect(TripMountain.count).to eql(prev_trip_mountain_count + 2)

  end

  scenario "filling out the form with one hiker included" do

    prev_trip_count = Trip.count
    prev_trip_participation_count = TripParticipation.count

    login_user(user)  
    user2

    visit new_trip_path

    fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"
    select user.user_name, from: "Hikers"
    select user2.user_name, from: "Hikers"

    click_on "Record Hike"

    expect(Trip.count).to eql(prev_trip_count + 1)
    expect(TripParticipation.count).to eql(prev_trip_participation_count + 2)
    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "updating hike" do
    login_user(user)
    visit edit_trip_path(trip)
    fill_in "Title", with: "New title"
    click_on "Record Hike"

    expect(page).to have_content "New title"
  end

end
