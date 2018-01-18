require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'ticket validation' do

		it 'should has a valid ticket' do
			FactoryGirl.build(:ticket).should be_valid
		end

		it 'should be invalid without a type_of_seat' do
			FactoryGirl.build(:ticket, type_of_seat: nil).should_not be_valid
		end

		it 'should be invalid without a price' do
			FactoryGirl.build(:ticket, price: nil).should_not be_valid
		end

		it 'should be invalid without a seat_no' do
			FactoryGirl.build(:ticket, seat_no: nil).should_not be_valid
		end

		it 'should be invalid without invalid price' do
			FactoryGirl.build(:ticket, price: 'sadfgh').should_not be_valid
		end

		it 'should be invalid without invalid seat_no' do
			FactoryGirl.build(:ticket, seat_no: 'dsfghj').should_not be_valid
		end

		it 'should be invalid with invalid type_of_seat' do
			FactoryGirl.build(:ticket, type_of_seat: 'sdfghj').should_not be_valid
		end

		it 'should be invalid without a booking' do
			FactoryGirl.build(:ticket, booking_id: nil).should_not be_valid
		end
	end

	context 'ticket associations' do

		it 'should belongs to audi'do
      audi = FactoryGirl.create(:audi)
      ticket = FactoryGirl.create(:ticket ,audi_id:audi.id)
      ticket.audi.id.should eq audi.id
    end

    it 'should not belong to invalid audi'do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      ticket = FactoryGirl.create(:ticket ,audi_id:audi1.id)
      ticket.audi.id.should eq audi1.id
      ticket.audi.id.should_not eq audi2.id
    end

    it 'should belongs to booking'do
      booking = FactoryGirl.create(:booking)
      ticket = FactoryGirl.create(:ticket ,booking_id:booking.id)
      ticket.booking.id.should eq booking.id
    end

    it 'should not belong to invalid booking'do
      booking1 = FactoryGirl.create(:booking)
      booking2 = FactoryGirl.create(:booking)
      ticket = FactoryGirl.create(:ticket ,booking_id:booking1.id)
      ticket.booking.id.should eq booking1.id
      ticket.booking.id.should_not eq booking2.id
    end

	end
end
