require 'spec_helper'
require 'pry'
describe Trip do

  it { should have_valid(:date).when(20120103) }
  it { should_not have_valid(:date).when('oops', '', nil, 5, 19000000, 20180912) }  

  it { should have_valid(:title).when("This is the title of the hike") }
  it { should_not have_valid(:title).when("", nil) }

  it { should have_many(:mountains) }
  it { should have_many(:hikers) } # but only one of them is the primary creator - is this a controller thing or a model thing?

end
