require 'spec_helper'

describe Mountain do
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
end
