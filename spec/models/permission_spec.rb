require "spec_helper"

RSpec::Matchers.define :permit do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end

describe Permission do 
  describe "as guest" do
    subject { Permission.new(nil) }
    it { should permit("welcome", "index") }
    it { should permit("mountains", "index") }
    it { should_not permit("mountains", "new") }
    it { should permit("mountains", "show") }
  end
end
