require 'spec_helper'

feature 'a user registers on the site', %q{
  As an unregistered user
  I want to create an account on the website
  So that I can begin recording my hikes
  } do

  # Acceptance Criteria:
  # * There is a new user option on the page
  # * I can enter a username, email address, and a password and password confirmation
  # * If I enter a username that is already in use, I receive an error message
  # * If I enter an invalid email address, I receive an error message
  # * If my username and email are valid and my password and password confirmation match, my account is created and I am automatically logged in
  # * I can make my account public or private
  # * I receive a welcome email
  scenario 'new user signs up from the front page with valid email and username' do
    visit root_path
    click_on "Sign up"
    fill_in "Trail name", with: "mskyle"
    fill_in "Email", with: "mskylehutchinson@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Re-enter password", with: "password"
    click_on "Let's go!"

    expect(page).to have_content "Welcome!"
  end

  scenario 'new user signs up from the front page with invalid email' do
    visit root_path
    click_on "Sign up"
    fill_in "Trail name", with: "mskyle"
    fill_in "Email", with: "mskylehutchinsongmail.com"
    fill_in "Password", with: "password"
    fill_in "Re-enter password", with: "password"
    click_on "Let's go!"

    expect(page).to have_content "is invalid"
  end

  scenario 'new user signs up from the front page with no user name' do
    visit root_path
    click_on "Sign up"
    fill_in "Trail name", with: ""
    fill_in "Email", with: "mskylehutchinsongmail.com"
    fill_in "Password", with: "password"
    fill_in "Re-enter password", with: "password"
    click_on "Let's go!"

    expect(page).to have_content "can't be blank"
  end

  scenario 'new user signs up from the front page with mismatched passwords' do
    visit root_path
    click_on "Sign up"
    fill_in "Trail name", with: "mskyle"
    fill_in "Email", with: "mskylehutchinson@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Re-enter password", with: "passrowd"
    click_on "Let's go!"

    expect(page).to have_content "doesn't match"
  end

  scenario 'new user attempts to sign up with email that is already in use' do
    visit root_path
    click_on "Sign up"
    fill_in "Trail name", with: "mskyle"
    fill_in "Email", with: "mskylehutchinson@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Re-enter password", with: "password"
    click_on "Let's go!"
    click_on "Logout"

    click_on "Sign up"
    fill_in "Trail name", with: "mskyle"
    fill_in "Email", with: "mskylehutchinson@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Re-enter password", with: "passrowd"
    click_on "Let's go!"
    
    expect(page).to have_content "been taken"
  end

end
