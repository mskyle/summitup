require 'spec_helper'

describe MountainList do
  it { should have_valid(:mountain_id).when(1, 2, 1434) }
  it { should_not have_valid(:mountain_id).when(1.2, "", nil, "four") }
end
