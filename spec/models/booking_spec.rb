require 'rails_helper'

RSpec.describe Booking, type: :model do
  context 'Booking validation' do

		it 'should be valid booking' do
			FactoryGirl.build(:booking).should be_valid
		end

		it 'should be invalid without a theater' do
			FactoryGirl.build(:booking, theater_id: nil).should_not be_valid
		end

		it 'should be invalid without a user' do
			FactoryGirl.build(:booking, user_id: nil).should_not be_valid
		end

		it 'should be invalid without a show_time' do
			FactoryGirl.build(:booking, show_time_id: nil).should_not be_valid
		end
	end
	context 'Booking associations' do

		it "should has many tickets" do
			@booking = FactoryGirl.create(:booking)
			@ticket1 = FactoryGirl.create(:ticket, booking_id: @booking.id)
			@ticket2 = FactoryGirl.create(:ticket, booking_id: @booking.id)
			@booking.tickets.should include @ticket1
			@booking.tickets.should include @ticket2
  	end

		it "should not has unincluded tickets" do
			@booking1 = FactoryGirl.create(:booking)
			@booking2 = FactoryGirl.create(:booking)
			@ticket1 = FactoryGirl.create(:ticket, booking_id: @booking1.id)
			@ticket2 = FactoryGirl.create(:ticket, booking_id: @booking2.id)
			@booking1.tickets.should include @ticket1
			@booking1.tickets.should_not include @ticket2
			@booking2.tickets.should include @ticket2
			@booking2.tickets.should_not include @ticket1
  	end

		it 'should belongs to theater'do
      theater = FactoryGirl.create(:theater)
      booking = FactoryGirl.create(:booking ,theater_id:theater.id)
      booking.theater.id.should eq theater.id
    end

    it 'should not belong to invalid theater'do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      booking = FactoryGirl.create(:booking ,theater_id:theater1.id)
      booking.theater.id.should eq theater1.id
      booking.theater.id.should_not eq theater2.id
    end

    it 'should belongs to user'do
      user = FactoryGirl.create(:user)
      booking = FactoryGirl.create(:booking, user_id:user.id)
      booking.user.id.should eq user.id
    end

    it 'should not belong to invalid user'do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      booking = FactoryGirl.create(:booking , user_id:user1.id)
      booking.user.id.should eq user1.id
      booking.user.id.should_not eq user2.id
    end

    it 'should belongs to show_time'do
      showTime= FactoryGirl.create(:show_time)
      booking = FactoryGirl.create(:booking ,show_time_id:showTime.id)
      booking.show_time.id.should eq showTime.id
    end

    it 'should not belong to invalid show_time'do
      showTime1 = FactoryGirl.create(:show_time)
      showTime2 = FactoryGirl.create(:show_time)
      booking = FactoryGirl.create(:booking ,show_time_id:showTime1.id)
      booking.show_time.id.should eq showTime1.id
      booking.show_time.id.should_not eq showTime2.id
    end
	end
end
