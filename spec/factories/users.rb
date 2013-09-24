# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "John Doe #{n}" }
    first_name "MyString"
    last_name "MyString"
    sequence(:email) { |n| "my#{n}@email.com" }
    password "password"
  end
end
