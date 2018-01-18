require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'movie validation' do

		it 'should be valid movie' do
			FactoryGirl.build(:movie).should be_valid
		end

		it 'should be invalid without a name' do
			FactoryGirl.build(:movie, name: nil).should_not be_valid
		end

		it 'should be invalid without a category' do
			FactoryGirl.build(:movie, category: nil).should_not be_valid
		end

		it 'should be invalid without a valid category' do
			FactoryGirl.build(:movie, category: 'sdsa').should_not be_valid
		end
	end
	context 'movie associations' do

		it "should has many show_times" do
			@movie = FactoryGirl.create(:movie)
			@showTime1 = FactoryGirl.create(:show_time, movie_id: @movie.id)
			@showTime2 = FactoryGirl.create(:show_time, movie_id: @movie.id)
			@movie.show_times.should include @showTime1
			@movie.show_times.should include @showTime2
  	end

		it "should not has unincluded show_times" do
			@movie1 = FactoryGirl.create(:movie)
			@movie2 = FactoryGirl.create(:movie)
			@showTime1 = FactoryGirl.create(:show_time, movie_id: @movie1.id)
			@showTime2 = FactoryGirl.create(:show_time, movie_id: @movie2.id)
			@movie1.show_times.should include @showTime1
			@movie1.show_times.should_not include @showTime2
			@movie2.show_times.should include @showTime2
			@movie2.show_times.should_not include @showTime1
  	end

		it "should has many movies" do
			@movie = FactoryGirl.create(:movie)
			@audi1 = FactoryGirl.create(:audi)
			@audi2 = FactoryGirl.create(:audi)
			@showTime1 = FactoryGirl.create(:show_time, movie_id: @movie.id, audi_id: @audi1.id)
			@showTime2 = FactoryGirl.create(:show_time, movie_id: @movie.id, audi_id: @audi2.id)
			@movie.audis.should include @audi1
			@movie.audis.should include @audi2
  	end

		it "should not has unincluded movies" do
			@movie1 = FactoryGirl.create(:movie)
			@movie2 = FactoryGirl.create(:movie)
			@audi1 = FactoryGirl.create(:audi)
			@audi2 = FactoryGirl.create(:audi)
			@showTime1 = FactoryGirl.create(:show_time, movie_id: @movie1.id, audi_id: @audi1.id)
			@showTime2 = FactoryGirl.create(:show_time, movie_id: @movie2.id, audi_id: @audi2.id)
			@movie1.audis.should include @audi1
			@movie2.audis.should_not include @audi1
			@movie1.audis.should_not include @audi2
			@movie2.audis.should include @audi2
  	end
	end
end
