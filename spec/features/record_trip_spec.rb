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

  let (:user) { FactoryGirl.create(:user) }

  scenario "filling out the form with minimum required attributes" do  
    #log in user
    
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"    

    visit '/trips/new'
    #fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"

    click_on "Record Hike"

    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "filling out the form with all available fill-in attributes" do
    #log in user
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"

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
    #log in user
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"    

    visit '/trips/new'

    click_on "Record Hike"

    expect(page).to have_content "can't be blank"
  end

  scenario "filling out the form with one mountain included" do
    #log in user
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"

    visit '/trips/new'
    #fill_in "Date", with: "09-13-2013"
    fill_in "Title", with: "My hike"
    fill_in "Notes", with: "It was pretty awesome!"
    select "Mt Washington", from: "Mountain"
    fill_in "Trails", with: "Ammonusuc Ravine, Jewell"
    fill_in "Book time", with: "90"
    fill_in "Actual time", with: "80"
    fill_in "Distance", with: "4"
    fill_in "Difficulty", with: "4"
    fill_in "Awesomeness", with: "4"
    click_on "Record Hike"

    expect(page).to have_content "Awesome! Your hike has been recorded."
  end

  scenario "filling out the form with multiple mountains included" do

  end

  scenario "filling out the form with hikers included" do

  end

end
