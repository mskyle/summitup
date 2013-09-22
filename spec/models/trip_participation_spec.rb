require 'spec_helper'

describe TripParticipation do
  
  it { should belong_to(:trip) }
  it { should belong_to(:user) }
  
  it { should have_valid(:trip).when(Trip.new) }
  it { should_not have_valid(:trip).when(nil) }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }
end
