FactoryGirl.define do
  factory :ticket do
		type_of_seat %w[star_class prime recliner].sample
		booking_id { FactoryGirl.create(:booking).id }
		audi_id { FactoryGirl.create(:audi).id }
		seat_no Faker::Number.number(2)
		price Faker::Number.decimal(3,2)    
  end
end
