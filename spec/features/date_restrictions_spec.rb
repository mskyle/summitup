require 'spec_helper' 

feature "date restrictions", %q{
  As a user
  I want to be stopped from entering in dates for hikes that are from, like, before I was born
  So that my hike record accurately reflects my personal hiking history
} do 

  # Acceptance criteria:
  # * when I input a hike, I can't input dates that are too early
  # * I cannot input dates that are too far in the future

  let (:user) { FactoryGirl.create(:user) }
  let (:trip) { FactoryGirl.build(:trip) }

  scenario 'I try to enter a date too far in the past' do 

    login_user(user)

    visit new_trip_path

    fill_in "Date", with: "09-13-1912"
    fill_in "Title", with: "My hike"

    click_on "Record Hike"

    expect(page).to have_content "can't be that far in the past"
  end

  scenario 'I try to enter a date too far in the past' do 

    login_user(user)

    visit new_trip_path

    fill_in "Date", with: "09-13-2015"
    fill_in "Title", with: "My hike"

    click_on "Record Hike"

    expect(page).to have_content "can't be in the future"
  end

end
