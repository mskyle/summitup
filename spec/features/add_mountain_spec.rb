require 'spec_helper'

feature 'an administrator creates a mountain', %q{
  As a signed-in administrator
  I want to create a record for a specific mountin
  So that other users can include it in their hikes
  } do
  # Acceptance Criteria:
  # * Mountain name, height, latitude and longitude are required
  # * I can optionally add a photo
  # * Only administrators can add a mountain
  let(:admin) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }
  let(:mountain) { FactoryGirl.create(:mountain) }

  scenario 'logged in user with appropriate permissions creates mountain' do
    login_user(admin)
    visit new_mountain_path
    fill_in "Name", with: mountain.name 
    fill_in "Height", with: mountain.height
    fill_in "Latitude", with: mountain.latitude
    fill_in "Longitude", with: mountain.longitude
    attach_file('Image', 'spec/support/images/stupid.jpg')
    click_button 'Add mountain'
    expect(page).to have_content(mountain.name, mountain.height, mountain.latitude)
    expect(Mountain.last.image.present?)
  end
end
