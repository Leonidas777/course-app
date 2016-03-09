FactoryGirl.define do
  factory :course do
    user

    sequence(:title)  { |n| "Course-#{n}" }
    active { true }
  end
end
