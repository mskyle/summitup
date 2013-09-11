require 'spec_helper'

describe TripMountain do
  it { should belong_to(:mountain) }
  it { should belong_to(:trip) } 

  it { should have_valid(:mountain_id).when(1) }
  it { should_not have_valid(:mountain_id).when("", nil)}
end
