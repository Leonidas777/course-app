FactoryGirl.define do
  factory :user do
    profile
    
    email    { Faker::Internet.email }
    password { '123321' }
  end
end
