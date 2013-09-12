require 'spec_helper'

describe List do
  it { should have_valid(:title).when("NE 100 Highest", "46ers") }
  it { should_not have_valid(:title).when("", nil) }

  it { should have_many(:mountains) }
end
