require 'rails_helper'

RSpec.describe ShowTimesController, type: :controller do
	context 'GET#index' do
    it 'should show all showTimes successfully' do
    	showTime1 = FactoryGirl.create(:show_time)
    	showTime2 = FactoryGirl.create(:show_time)
      get :index, format: 'json'
      assigns(:showTimes).should include showTime1
      assigns(:showTimes).should include showTime2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get showTime successfully' do
      showTime = FactoryGirl.create(:show_time)
      get :show, id: showTime.id, format: 'json'
      assigns(:showTime).should eq showTime
      response.should have_http_status(:ok)
    end

    it 'should not get invalid showTime' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new showTime successfully' do
      get :new, format: 'json'
      assigns(:showTime).id.should eq nil
      assigns(:showTime).movie_id.should eq nil
      assigns(:showTime).audi_id.should eq nil
      assigns(:showTime).time_of_show.should eq nil
      assigns(:showTime).date_of_show.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct showTime successfully' do
      showTime = FactoryGirl.create(:show_time)
      get :edit, id: showTime.id,format: 'json'
      assigns(:showTime).should eq showTime
      response.should have_http_status(:ok)
    end

    it 'should not get showTime with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create showTime successfully' do
      showTime = FactoryGirl.create(:show_time)
      post :create, show_time: { movie_id: showTime.movie_id,audi_id: showTime.audi_id,time_of_show: showTime.time_of_show,date_of_show: showTime.date_of_show },format: 'json'
      assigns(:showTime).movie_id.should eq showTime.movie_id
      assigns(:showTime).audi_id.should eq showTime.audi_id
      assigns(:showTime).time_of_show.should eq showTime.time_of_show
      assigns(:showTime).date_of_show.should eq showTime.date_of_show
      response.should have_http_status(:created)
    end

    it 'should not create showTime with invalid input' do
      post :create, show_time: { movie_id: nil,audi_id: nil,time_of_show: nil,date_of_show: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
 
    it 'should not create showTime with invalid movie_id' do
      showTime = FactoryGirl.create(:show_time)
      post :create, show_time: { movie_id: '12345',audi_id: showTime.audi_id,time_of_show: showTime.time_of_show,date_of_show: showTime.date_of_show },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create showTime with invalid audi_id' do
      showTime = FactoryGirl.create(:show_time)
      post :create, show_time: { movie_id: showTime.movie_id,audi_id: '123456',time_of_show: showTime.time_of_show,date_of_show: showTime.date_of_show },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update showTime successfully' do
      showTime1 = FactoryGirl.create(:show_time)
      showTime2 = FactoryGirl.create(:show_time)
      put :update,id: showTime1.id, show_time: { movie_id: showTime2.movie_id,audi_id: showTime2.audi_id,time_of_show: showTime2.time_of_show,date_of_show: showTime2.date_of_show },format: 'json'
      assigns(:showTime).id.should eq showTime1.id
      assigns(:showTime).movie_id.should eq showTime2.movie_id
      assigns(:showTime).audi_id.should eq showTime2.audi_id
      assigns(:showTime).time_of_show.should eq showTime2.time_of_show
      assigns(:showTime).date_of_show.should eq showTime2.date_of_show
      response.should have_http_status(:ok)
    end

    it 'should not update showTime with invalid inputs' do
      showTime1 = FactoryGirl.create(:show_time)
      put :update,id: showTime1.id, show_time: { movie_id: nil,audi_id: nil,time_of_show: nil,date_of_show: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update showTime with invalid movie_id' do
      showTime1 = FactoryGirl.create(:show_time)
      showTime2 = FactoryGirl.create(:show_time)
      put :update,id: showTime1.id, show_time: { movie_id: '123456',audi_id: showTime2.audi_id,time_of_show: showTime2.time_of_show,date_of_show: showTime2.date_of_show },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update showTime with invalid audi_id' do
      showTime1 = FactoryGirl.create(:show_time)
      showTime2 = FactoryGirl.create(:show_time)
      put :update,id: showTime1.id, show_time: { movie_id: showTime2.movie_id,audi_id: '123456',time_of_show: showTime2.time_of_show,date_of_show: showTime2.date_of_show },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update movie with invalid category' do
      showTime = FactoryGirl.create(:show_time)
      put :update,id: '123456', show_time: { movie_id: showTime.movie_id,audi_id: showTime.audi_id,time_of_show: showTime.time_of_show,date_of_show: showTime.date_of_show },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy showTime successfully' do
      showTime = FactoryGirl.create(:show_time)
      delete :destroy, id: showTime.id,format: 'json'
      assigns(:showTime).should eq showTime
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid showTime' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
