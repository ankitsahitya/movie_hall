FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    age	Faker::Number.number(2)
    phone_no Faker::Number.number(10)
  end
end
