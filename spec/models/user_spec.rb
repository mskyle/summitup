require 'spec_helper'

describe User do
  it { should have_valid(:user_name).when("mskyle", "Bamaman", "OldGrayGoose", "Gonzo") }
  it { should_not have_valid(:user_name).when("", nil) } 

  it { should have_valid(:email).when("mskylehutchinson@gmail.com", "judy@hotmail.com", "furgie413@yahoo.com") }
  it { should_not have_valid(:email).when("mskyle@com", "tweet", "", nil, "bruce@gmail", "frenchie.com") }

  it { should have_many(:trips) }
  it { should have_many(:mountains) }

end
