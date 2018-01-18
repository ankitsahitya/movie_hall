FactoryGirl.define do
  factory :movie do
    name Faker::Name.name
    category %w[U U/A A].sample
  end
end
