require 'spec_helper'

feature 'mountain listings', %q{
  As a hiker
  I want to be able to pull up a list of mountains I've already summited and mountains I have yet to summit
  So that I can geek out over my peakbagging progress, recall past hikes, and identify mountains I might want to climb in the future
} do 
  # Acceptance Criteria:
  # * I can view a sortable list of all the mountains covered by the app
  # * In the list mountains are marked depending on whether they've been hiked and completed, hiked but not completed (attempted), or not attempted
  # * I can view a list of mountains I have summited
  # * I can view a list of the mountains I have not yet summited
  # * The date of the most recent summit or summit attempt is displayed
  let (:created_mountains) { FactoryGirl.create_list(:mountain, 25) }


  scenario 'user looks at a list of all the mountains on the site' do
    created_mountains
    visit mountains_path

    expect(page).to have_content("Mountains")
    expect(page).to have_content(created_mountains[0].name)
    expect(page).to have_content(created_mountains[-1].name)
  end

  scenario 'user views list of mountains sorted by height, descending' do
    one_footer = FactoryGirl.create(:mountain, height: 1)
    hundred_footer = FactoryGirl.create(:mountain, height: 100)
    thousand_footer = FactoryGirl.create(:mountain, height: 1000)

    visit mountains_path

    (thousand_footer.name).should appear_before(hundred_footer.name)
    (hundred_footer.name).should appear_before(one_footer.name)
  end

  scenario 'user views list of mountains sorted by height, ascending' do
    thousand_footer = FactoryGirl.create(:mountain, height: 1000)    
    one_footer = FactoryGirl.create(:mountain, height: 1)
    hundred_footer = FactoryGirl.create(:mountain, height: 100)

    visit mountains_path
    click_on "Height"

    (one_footer.name).should appear_before(hundred_footer.name)
    (hundred_footer.name).should appear_before(thousand_footer.name)
  end

    scenario 'user views list of mountains sorted by name, descending' do
    a_mountain = FactoryGirl.create(:mountain, name: "Abraham")
    b_mountain = FactoryGirl.create(:mountain, name: "Bigelow")
    c_mountain = FactoryGirl.create(:mountain, name: "Cannon")

    visit mountains_path
    click_on "Name"
    click_on "Name"

    (b_mountain.name).should appear_before(a_mountain.name)
    (c_mountain.name).should appear_before(b_mountain.name)
  end

  scenario 'user views list of mountains sorted by height, ascending' do
    c_mountain = FactoryGirl.create(:mountain, name: "Cannon", height: "100")
    a_mountain = FactoryGirl.create(:mountain, name: "Abraham", height: "100")
    b_mountain = FactoryGirl.create(:mountain, name: "Bigelow", height: "100")


    visit mountains_path
    click_on "Name"

    (a_mountain.name).should appear_before(b_mountain.name)
    (b_mountain.name).should appear_before(c_mountain.name)
  end

  scenario 'user views a sortable list of all the mountains she has hiked' 

  scenario 'mountains a user has hiked look different from mountains she has not hiked' 

  scenario 'user can view a sortable list of all the mountains she has not yet ßhiked'
end