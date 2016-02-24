FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { '123321' }
  end
end
