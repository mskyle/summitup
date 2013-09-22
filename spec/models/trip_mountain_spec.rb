require 'spec_helper'

describe TripMountain do

  it { should belong_to(:mountain) }
  it { should belong_to(:trip) } 

  it { should have_valid(:mountain).when(Mountain.new) }
  it { should_not have_valid(:mountain).when(nil) }

  it { should have_valid(:trip).when(Trip.new) }
  it { should_not have_valid(:trip).when(nil) }
  
end
