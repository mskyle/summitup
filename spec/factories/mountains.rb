# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mountain do
    name "MyString"
    height 1
    latitude "9.99"
    longitude "9.99"
    notes "MyText"
  end
end
