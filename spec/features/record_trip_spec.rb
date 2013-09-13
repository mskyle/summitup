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

  context "with minimum required attributes" do  
    it "creates a hike record" do
      visit '/trips/new'

      #fill_in "Date", with: "09-13-2013"
      fill_in "Title", with: "My hike"

      click_on "Record Hike"

      expect(page).to have_content "Awesome! Your hike has been recorded."
    end
  end
end
