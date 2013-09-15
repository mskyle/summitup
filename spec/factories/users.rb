# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    user_name "MyString"
    first_name "MyString"
    last_name "MyString"
    email "my@email.com"
    password "password"
  end
end
