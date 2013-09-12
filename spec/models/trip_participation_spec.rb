require 'spec_helper'

describe TripParticipation do
  
  it { should have_valid(:trip_id).when(1,2,4,5,23094) }
  it { should_not have_valid(:trip_id).when(1.2, "", nil, "fifteen") }

  it { should have_valid(:user_id).when(1,2,4,5,23094) }
  it { should_not have_valid(:user_id).when(1.2, "", nil, "fifteen") }

end
