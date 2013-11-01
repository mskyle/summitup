require 'spec_helper'

feature 'signed-in user logs out', %q{
  As a signed-in user
  I want to be able to sign out of the website
  So that I don't leave a bunch of personal information up on my computer
  } do

  # Acceptance criteria:
  # * There is a log out option on the page
  # * When I select it my account is closed and I am no longer able to access non-public information on the site
  let (:user) { FactoryGirl.create(:user) }

  scenario 'logout option appears when user is logged in' do
    visit root_path
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"

    expect(page).to have_content "Logout"
  end

  scenario 'user tries to record hike without logging in' do
    visit new_trip_path
    expect(page).to have_content "Not authorized"
  end

end
