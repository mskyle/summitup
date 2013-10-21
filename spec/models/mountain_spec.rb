require 'spec_helper'

describe Mountain do
  let!(:trip) { FactoryGirl.create(:trip) }
  let!(:mountain) { FactoryGirl.create(:mountain, height: 500) }
  let!(:mountain2) { FactoryGirl.create(:mountain, height: 1500) }
  let!(:mountain3) { FactoryGirl.create(:mountain, height: 500) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:trip_participation) { FactoryGirl.create(:trip_participation, trip: trip, user: user)
  }
  let!(:trip_mountain) { FactoryGirl.create(:trip_mountain, trip: trip, mountain: mountain) }
  let!(:list) { FactoryGirl.create(:list) }
  let!(:mountain_list) { FactoryGirl.create(:mountain_list, list: list, mountain: mountain) }

  it { should have_valid(:name).when("Mt. Washington", "Kinsman", "East Osceola") }
  it { should_not have_valid(:name).when("", nil) }

  it { should have_valid(:height).when(4600) }
  it { should_not have_valid(:height).when(nil, "", "peas", -45, 25000) }

  it { should have_valid(:latitude).when(46, 30.12345, -89, -30.243) }
  it { should_not have_valid(:latitude).when(100, -100, nil, "foo") }

  it { should have_valid(:longitude).when(120.1234, 25, -178.134987, -1, 0) }
  it { should_not have_valid(:longitude).when(195, "", nil, "pants") }

  it { should have_many(:trips) }
  it { should have_many(:lists) }

  it 'finds all the mountains a user has already hiked' do
    expect(Mountain.filter({hiked: :hiked}, user).include?(mountain)).to eql(true) 
    expect(Mountain.filter({hiked: :hiked}, user).include?(mountain2)).to eql(false)     
  end

  it 'finds all the mountains a user has not yet hiked' do
    expect(Mountain.filter({hiked: :unhiked}, user).include?(mountain)).to eql(false)
    expect(Mountain.filter({hiked: :unhiked}, user).include?(mountain2)).to eql(true)
  end

  it 'finds all the mountains from a mountain list' do
    expect(Mountain.filter({list: list.id}, user).include?(mountain)).to eql(true)
    expect(Mountain.filter({list: list.id}, user).include?(mountain2)).to eql(false)
  end

  it 'finds all the mountains within a certain height range' do
    expect(Mountain.filter({height: {top: 1000, floor: 0}}, user).include?(mountain)).to eql(true)
    expect(Mountain.filter({height: {top: 1000, floor: 400}}, user).include?(mountain2)).to eql(false)
    expect(Mountain.filter({height: {top: 2000, floor: 1000}}, user).include?(mountain2)).to eql(true)
  end

  it 'combines different filters' do 
    filter_hash = {
      height: {top: 1000, floor: 0},
      list: list.id,
      hiked: :hiked
    }
    expect(Mountain.filter(filter_hash, user).include?(mountain)).to eql(true)
    expect(Mountain.filter(filter_hash, user).include?(mountain2)).to eql(false)
    expect(Mountain.filter(filter_hash, user).include?(mountain3)).to eql(false)
  end

  it 'combines different filters' do 
    filter_hash = {
      list: list.id,
      hiked: :hiked
    }
    expect(Mountain.filter(filter_hash, user).include?(mountain)).to eql(true)
    expect(Mountain.filter(filter_hash, user).include?(mountain2)).to eql(false)
    expect(Mountain.filter(filter_hash, user).include?(mountain3)).to eql(false)
  end

  it 'has an alphabetical name for ordering purposes' do
    mountain = FactoryGirl.create(:mountain, name: "Mount Smores")
    expect(mountain.alphabetical_name).to eql("SmoresMount")
  end

  it 'has a height in feet' do
    expect(mountain.height_in_feet).to eql((mountain.height * 3.28084).round)
  end
end
