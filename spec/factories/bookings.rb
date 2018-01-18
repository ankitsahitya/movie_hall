FactoryGirl.define do
  factory :booking do
 		theater_id { FactoryGirl.create(:theater).id }
 		user_id { FactoryGirl.create(:user).id }
 		show_time_id { FactoryGirl.create(:show_time).id }
  end
end
