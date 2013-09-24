require 'spec_helper'

describe MountainList do
  it { should have_valid(:mountain).when(Mountain.new) }
  it { should_not have_valid(:mountain).when(nil) }

  it { should have_valid(:list).when(List.new) }
  it { should_not have_valid(:list).when(nil) }
end
