# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip_participation do
    user
    trip
  end
end
