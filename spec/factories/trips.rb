FactoryGirl.define do
  factory :trip do
    date Date.today
    sequence(:title) { |n| "Cool hike bro #{n}" }
    note "Oh man what a great hike seriously."
    trails "Sawyer River Road"
    book_time 90
    actual_time 120
    distance 8.2
    hike_difficulty 4
    hike_awesomeness 4
  end
end
