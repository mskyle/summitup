require 'spec_helper'

feature 'a user views her profile', %Q{
  As a user
  I want to be able to see my profile
  So that I can make sure I look awesome on the internet
} do

  let(:user) { FactoryGirl.create(:user) }

  # Acceptance Criteria
  # * I can see my stored profile information
  # * Users who are not logged in cannot see my profile

  scenario 'I visit my profile page' do
    login_user(user)
    visit user_path(user)
    expect(page).to have_content(user.user_name, user.first_name, user.last_name)
  end

  scenario 'I visit my profile page' do
    login_user(user)
    original_name = "#{user.first_name} #{user.last_name}"
    visit user_path(user)
    click_on "Edit"
    fill_in "First name", with: "Julie"
    fill_in "Last name", with: "Horncastle"
    fill_in "Current password", with: user.password
    click_on "Update"

    visit user_path(user)

    expect(page).to have_content("Julie Horncastle")
    expect(page).to_not have_content(original_name)
  end

end
