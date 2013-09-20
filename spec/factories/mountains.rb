# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mountain do
    sequence(:name) { |n| "Mount #{n}Everest" }
    height 1
    latitude "9.99"
    longitude "9.99"
    sequence(:notes) { |n| "These are #{n}notes" }
  end
end
