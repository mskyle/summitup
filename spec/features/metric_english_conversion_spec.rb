require 'spec_helper'

feature 'view and enter units in miles/feet or km/meters', %q{
  As a hiker
  I want to be able to view mountain heights and hike distances in the units of my choice
  Because some hikers like to think in meters and km and some like to think in feet and miles.
} do 
  # Acceptance criteria
  # * I can set and change my default unit preference as part of my profile
  # * When entering hike mileage I can specify whether I am entering it in meters or feet
  # * When I view a hike I can specify whether I want to view the units in english or metric
  # * When I view a mountain or mountain list I can specify whether I want to view heights in english or metric

  scenario 'viewing the mountain list in meters or feet' do
    mountain = FactoryGirl.create(:mountain)

    visit mountains_path

    click_on "meters"

    expect(page).to have_content(mountain.height)

    click_on "feet"

    expect(page).to have_content(mountain.feet_height)
  end 
end