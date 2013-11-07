require "spec_helper"

RSpec::Matchers.define :permit do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end

describe Permission do 
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user_trip) { FactoryGirl.create(:trip, users: [user]) }
  let!(:other_trip) { FactoryGirl.create(:trip) }
  
  describe "as guest" do
    subject { Permission.new(nil) }
    it { should permit("welcome", "index") }
    it { should permit("mountains", "index") }
    it { should_not permit("mountains", "new") }
    it { should_not permit("mountains", "edit") }
    it { should permit("mountains", "show") }
    it { should_not permit("mountains", "create") }
    it { should_not permit("mountains", "update") }
    it { should_not permit("mountains", "destroy") }
    it { should_not permit("trips", "show") }
    it { should_not permit("trips", "edit") }
    it { should_not permit("trips", "new") }
    it { should_not permit("trips", "index") }
    it { should_not permit("trips", "create") }
    it { should_not permit("trips", "update") }
    it { should_not permit("trips", "destroy") }
  end

  describe "as user" do
    subject { Permission.new(user) }
    it { should permit("welcome", "index") }
    it { should permit("mountains", "index") }
    it { should_not permit("mountains", "new") }
    it { should_not permit("mountains", "edit") }
    it { should permit("mountains", "show") }
    it { should_not permit("mountains", "create") }
    it { should_not permit("mountains", "update") }
    it { should_not permit("mountains", "destroy") }
    it { should_not permit("trips", "show", other_trip) }
    it { should_not permit("trips", "edit", other_trip) }   
    it { should permit("trips", "new") }
    it { should permit("trips", "show", user_trip) }
    it { should permit("trips", "edit", user_trip) }  
    it { should permit("trips", "index") }
    it { should permit("trips", "create") }
    it { should permit("trips", "update", user_trip) }
    it { should permit("trips", "destroy", user_trip) }
    it { should_not permit("trips", "update", other_trip) }
    it { should_not permit("trips", "destroy", other_trip) }
  end

  describe "as admin" do
    subject { Permission.new(admin) }
    it { should permit("welcome", "index") }
    it { should permit("mountains", "index") }
    it { should permit("mountains", "new") }
    it { should permit("mountains", "edit") }
    it { should permit("mountains", "show") }
    it { should permit("mountains", "create") }
    it { should permit("mountains", "update") }
    it { should permit("mountains", "destroy") }
    it { should permit("trips", "show") }
    it { should permit("trips", "edit") }
    it { should permit("trips", "new") }
    it { should permit("trips", "index") }
    it { should permit("trips", "create") }
    it { should permit("trips", "update") }
    it { should permit("trips", "destroy") }
  end
end
