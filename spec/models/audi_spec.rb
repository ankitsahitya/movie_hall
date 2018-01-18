require 'rails_helper'

RSpec.describe Audi, type: :model do
  context 'Audi validation' do

		it 'should be valid audi' do
			FactoryGirl.build(:audi).should be_valid
		end

		it 'should be invalid without a number' do
			FactoryGirl.build(:audi, number: nil).should_not be_valid
		end

		it 'should be invalid without a number' do
			FactoryGirl.build(:audi, number: 'asdfghj').should_not be_valid
		end

		it 'should be invalid without a theater' do
			FactoryGirl.build(:audi, theater_id: nil).should_not be_valid
		end
	end
	
	context 'audi associations' do

		it "should has many show_times" do
			@audi = FactoryGirl.create(:audi)
			@showTime1 = FactoryGirl.create(:show_time, audi_id: @audi.id)
			@showTime2 = FactoryGirl.create(:show_time, audi_id: @audi.id)
			@audi.show_times.should include @showTime1
			@audi.show_times.should include @showTime2
  	end

		it "should not has unincluded show_times" do
			@audi1 = FactoryGirl.create(:audi)
			@audi2 = FactoryGirl.create(:audi)
			@showTime1 = FactoryGirl.create(:show_time, audi_id: @audi1.id)
			@showTime2 = FactoryGirl.create(:show_time, audi_id: @audi2.id)
			@audi1.show_times.should include @showTime1
			@audi1.show_times.should_not include @showTime2
			@audi2.show_times.should include @showTime2
			@audi2.show_times.should_not include @showTime1
  	end

		it "should has many movies" do
			@movie1 = FactoryGirl.create(:movie)
			@movie2 = FactoryGirl.create(:movie)
			@audi = FactoryGirl.create(:audi)
			@showTime1 = FactoryGirl.create(:show_time, movie_id: @movie1.id, audi_id: @audi.id)
			@showTime2 = FactoryGirl.create(:show_time, movie_id: @movie2.id, audi_id: @audi.id)
			@audi.movies.should include @movie1
			@audi.movies.should include @movie2
  	end

		it "should not has unincluded movies" do
			@movie1 = FactoryGirl.create(:movie)
			@movie2 = FactoryGirl.create(:movie)
			@audi1 = FactoryGirl.create(:audi)
			@audi2 = FactoryGirl.create(:audi)
			@showTime1 = FactoryGirl.create(:show_time, movie_id: @movie1.id, audi_id: @audi1.id)
			@showTime2 = FactoryGirl.create(:show_time, movie_id: @movie2.id, audi_id: @audi2.id)
			@audi1.movies.should include @movie1
			@audi1.movies.should_not include @movie2
			@audi2.movies.should include @movie2
			@audi2.movies.should_not include @movie1
  	end

  	it 'should belongs to theater'do
      theater = FactoryGirl.create(:theater)
      audi = FactoryGirl.create(:audi ,theater_id:theater.id)
      audi.theater.id.should eq theater.id
    end

    it 'should not belong to invalid theater'do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      audi = FactoryGirl.create(:audi ,theater_id:theater1.id)
      audi.theater.id.should eq theater1.id
      audi.theater.id.should_not eq theater2.id
    end
	end
end
