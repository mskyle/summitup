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
  # * I can set privacy setting for the hike

  scenario "filling out the form with minimum required attributes" do  
    visit '/trips/new'

    #fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"

    click_on "Record Hike"

    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "filling out the form with all available fill-in attributes" do

    visit '/trips/new'
    #fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"
    fill_in "Notes", with: "It was pretty awesome!"
    fill_in "Trails", with: "Ammonusuc Ravine, Jewell"
    fill_in "Book time", with: "90"
    fill_in "Actual time", with: "80"
    fill_in "Distance", with: "4"
    fill_in "Difficulty", with: "4"
    fill_in "Awesomeness", with: "4"
    click_on "Record Hike"

    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "filling out the form with insufficient attributes" do
    visit '/trips/new'

    click_on "Record Hike"

    expect(page).to have_content "can't be blank"
  end

  scenario "filling out the from with mountains and hikers included" do

  end

end
