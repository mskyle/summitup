require 'spec_helper'

feature 'a registered user logs in to the site', %q{
  As a registered user
  I want to be able to log in to the website
  So that I can see my existing hikes and record new ones
  } do

  # Acceptance Criteria:
  # * There is a sign-in option on the page if I am not already logged in
  # * My password is not displayed as I enter it
  # * If I enter the correct username and password, I am logged in and a message to that effect is displayed onscreen
  # * If I enter incorrect information an error message is displayed and I am not authenticated
  # * If I am already logged in the log in option goes away

  let (:user) { FactoryGirl.create(:user) }

  scenario 'registered user signs in from the front page with valid email and password' do
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"

    expect(page).to have_content "Logged in as #{user.user_name}"
  end

  scenario 'registered user signs in from the front page with valid email and password' do
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Let's go!"

    expect(page).to have_no_content "Login"
  end

  scenario 'registered user tries to sign in with wrong password' do
    visit "/"
    click_on "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: "foo"
    click_on "Let's go!"

    expect(page).to have_content "Invalid"
  end

  scenario 'someone tries to sign in with unregistered email' do
    visit "/"
    click_on "Login"
    fill_in "Email", with: "me@you.com"
    fill_in "Password", with: user.password
    click_on "Let's go!"

    expect(page).to have_content "Invalid"
  end

end