FactoryGirl.define do
  factory :lesson do
    course_id { 15 }
    sequence(:title)  { |n| "Lesson-#{n}" }
    description { Faker::Lorem.paragraph }
    sequence(:position) { |n| n }
    summary { Faker::Lorem.paragraph }
    homework { Faker::Lorem.paragraph }
    sequence(:meeting_datetime) { |n| n.minute.from_now }
    # meeting_datetime { 3.minute.from_now }
  end
end
