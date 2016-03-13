FactoryGirl.define do
  factory :lesson do
    sequence(:title)  { |n| "Lesson-#{n}" }
    description { Faker::Lorem.paragraph }
    sequence(:position) { |n| n}
    summary { Faker::Lorem.paragraph }
    homework { Faker::Lorem.paragraph }
    sequence(:date) { |n| n.day.from_now }
  end
end
