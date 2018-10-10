FactoryGirl.define do
  factory :audi do
    theater_id { FactoryGirl.create(:theater).id }
  	number Faker::Number.number(2)
  end
end
