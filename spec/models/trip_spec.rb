require 'spec_helper'

describe Trip do

  it { should have_valid(:date).when(Date.today) }
  it { should_not have_valid(:date).when('oops', '', nil, 5) }  

  it { should have_valid(:title).when("This is the title of the hike") }
  it { should_not have_valid(:title).when("", nil) }

  it { should have_many(:mountains) }
  it { should have_many(:users) } # but only one of them is the primary creator - is this a controller thing or a model thing?

end
