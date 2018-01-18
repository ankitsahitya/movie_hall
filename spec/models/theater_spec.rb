require 'rails_helper'

RSpec.describe Theater, type: :model do
	context 'theater validation' do

		it 'should be valid theater' do
			FactoryGirl.build(:theater).should be_valid
		end

		it 'should be invalid without a name' do
			FactoryGirl.build(:theater, name: nil).should_not be_valid
		end

		it 'should be invalid without a address' do
			FactoryGirl.build(:theater, address: nil).should_not be_valid
		end

		it 'should be invalid without a phone_no' do
			FactoryGirl.build(:theater, phone_no: nil).should_not be_valid
		end

		it 'should be invalid with short phone_no' do
			FactoryGirl.build(:theater, phone_no: '7982317').should_not be_valid
		end

		it 'should be invalid with long phone_no' do
			FactoryGirl.build(:theater, phone_no: '8978237874794734797288799').should_not be_valid
		end

		it 'should be invalid with invalid phone_no' do
			FactoryGirl.build(:theater, phone_no: 'asdfg').should_not be_valid
		end

	end

	context 'theater associations' do
		
		it "should has many audis" do
			@theater = FactoryGirl.create(:theater)
			@audi1 = FactoryGirl.create(:audi, theater_id: @theater.id)
			@audi2 = FactoryGirl.create(:audi, theater_id: @theater.id)
			@theater.audis.should include @audi1
			@theater.audis.should include @audi2
  	end

		it "should not has unincluded audis" do
			@theater1 = FactoryGirl.create(:theater)
			@theater2 = FactoryGirl.create(:theater)
			@audi1 = FactoryGirl.create(:audi, theater_id: @theater1.id)
			@audi2 = FactoryGirl.create(:audi, theater_id: @theater2.id)
			@theater1.audis.should include @audi1
			@theater1.audis.should_not include @audi2
			@theater2.audis.should include @audi2
			@theater2.audis.should_not include @audi1
  	end

		it "should has many bookings" do
			@theater = FactoryGirl.create(:theater)
			@booking1 = FactoryGirl.create(:booking, theater_id: @theater.id)
			@booking2 = FactoryGirl.create(:booking, theater_id: @theater.id)
			@theater.bookings.should include @booking1
			@theater.bookings.should include @booking2
  	end

		it "should not has unincluded bookings" do
			@theater1 = FactoryGirl.create(:theater)
			@booking1 = FactoryGirl.create(:booking, theater_id: @theater1.id)
			@theater2 = FactoryGirl.create(:theater)
			@booking2 = FactoryGirl.create(:booking, theater_id: @theater2.id)
			@theater1.bookings.should include @booking1
			@theater1.bookings.should_not include @booking2
			@theater2.bookings.should include @booking2
			@theater2.bookings.should_not include @booking1
  	end
	end
end
