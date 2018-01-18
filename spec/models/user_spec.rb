require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user validation' do

		it 'should have a valid user' do
			FactoryGirl.build(:user).should be_valid
		end

		it 'should be invalid without a name' do
			FactoryGirl.build(:user, name: nil).should_not be_valid
		end

		it 'should be invalid without a age' do
			FactoryGirl.build(:user, age: nil).should_not be_valid
		end

		it 'should be invalid without a phone_no' do
			FactoryGirl.build(:user, phone_no: nil).should_not be_valid
		end

		it 'should be invalid with short phone_no' do
			FactoryGirl.build(:user, phone_no: '7982317').should_not be_valid
		end

		it 'should be invalid with long phone_no' do
			FactoryGirl.build(:user, phone_no: '8978237874794734797288799').should_not be_valid
		end

		it 'should be invalid with invalid phone_no' do
			FactoryGirl.build(:user, phone_no: 'sdxfghj').should_not be_valid
		end
	end
	context 'user associations' do

		it "should has many bookings" do
			@user = FactoryGirl.create(:user)
			@booking1 = FactoryGirl.create(:booking, user_id: @user.id)
			@booking2 = FactoryGirl.create(:booking, user_id: @user.id)
			@user.bookings.should include @booking1
			@user.bookings.should include @booking2
  	end

		it "should not has unincluded bookings" do
			@user1 = FactoryGirl.create(:user)
			@booking1 = FactoryGirl.create(:booking, user_id: @user1.id)
			@user2 = FactoryGirl.create(:user)
			@booking2 = FactoryGirl.create(:booking, user_id: @user2.id)
			@user1.bookings.should include @booking1
			@user1.bookings.should_not include @booking2
			@user2.bookings.should include @booking2
			@user2.bookings.should_not include @booking1
  	end


	end
end
