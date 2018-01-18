FactoryGirl.define do
  factory :show_time do
  	movie_id { FactoryGirl.create(:movie).id }
  	audi_id { FactoryGirl.create(:audi).id }
    time_of_show Faker::Time.between(2.days.ago, Date.today, :all).strftime("%T")
    date_of_show Faker::Date.between(2.days.ago, Date.today).strftime("%F")
  end
end
