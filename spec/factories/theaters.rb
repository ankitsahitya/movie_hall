FactoryGirl.define do
  factory :theater do
    name Faker::Company.name
    address Faker::Address.street_address
    phone_no Faker::Number.number(10)
  end
end
