require 'rails_helper'

RSpec.describe ShowTime, type: :model do
  context 'show_time validation' do

		it 'should be valid show_time' do
			FactoryGirl.create(:show_time).should be_valid
		end

		it 'should be invalid without a time' do
			FactoryGirl.build(:show_time, time_of_show: nil).should_not be_valid
		end

		it 'should be invalid without a date' do
			FactoryGirl.build(:show_time, date_of_show: nil).should_not be_valid
		end

		it 'should be invalid without a audi' do
			FactoryGirl.build(:show_time, audi_id: nil).should_not be_valid
		end

		it 'should be invalid without a movie' do
			FactoryGirl.build(:show_time, movie_id: nil).should_not be_valid
		end
	end
	context 'show_time associations' do
		
		it "should has many bookings" do
			@showTime = FactoryGirl.create(:show_time)
			@booking1 = FactoryGirl.create(:booking, show_time_id: @showTime.id)
			@booking2 = FactoryGirl.create(:booking, show_time_id: @showTime.id)
			@showTime.bookings.should include @booking1
			@showTime.bookings.should include @booking2
  	end

		it "should not has unincluded bookings" do
			@showTime1 = FactoryGirl.create(:show_time)
			@booking1 = FactoryGirl.create(:booking, show_time_id: @showTime1.id)
			@showTime2 = FactoryGirl.create(:show_time)
			@booking2 = FactoryGirl.create(:booking, show_time_id: @showTime2.id)
			@showTime1.bookings.should include @booking1
			@showTime1.bookings.should_not include @booking2
			@showTime2.bookings.should include @booking2
			@showTime2.bookings.should_not include @booking1
  	end

  	it 'should belongs to audi'do
      audi = FactoryGirl.create(:audi)
      showTime = FactoryGirl.create(:show_time ,audi_id:audi.id)
      showTime.audi.id.should eq audi.id
    end

    it 'should not belong to invalid audi'do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      showTime = FactoryGirl.create(:show_time ,audi_id:audi1.id)
      showTime.audi.id.should eq audi1.id
      showTime.audi.id.should_not eq audi2.id
    end

    it 'should belongs to movie'do
      movie = FactoryGirl.create(:movie)
      showTime = FactoryGirl.create(:show_time ,movie_id:movie.id)
      showTime.movie.id.should eq movie.id
    end

    it 'should not belong to invalid movie'do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      showTime = FactoryGirl.create(:show_time ,movie_id:movie1.id)
      showTime.movie.id.should eq movie1.id
      showTime.movie.id.should_not eq movie2.id
    end

	end
end
