require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
	context 'GET#index' do
    it 'should get all the bookings successfully' do
    	booking1 = FactoryGirl.create(:booking)
    	booking2 = FactoryGirl.create(:booking)
      get :index, format: 'json'
      assigns(:bookings).should include booking1
      assigns(:bookings).should include booking2
    end
  end

	context 'GET#show' do
    it 'should get booking successfully' do
      booking = FactoryGirl.create(:booking)
      get :show, id: booking.id, format: 'json'
      assigns(:booking).should eq booking
      response.should have_http_status(:ok)
    end

    it 'should not get invalid booking' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new booking successfully' do
      get :new, format: 'json'
      assigns(:booking).id.should eq nil
      assigns(:booking).user_id.should eq nil
      assigns(:booking).theater_id.should eq nil
      assigns(:booking).show_time_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct booking successfully' do
      booking = FactoryGirl.create(:booking)
      get :edit, id: booking.id,format: 'json'
      assigns(:booking).should eq booking
      response.should have_http_status(:ok)
    end

    it 'should not get booking with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create booking successfully' do
      booking = FactoryGirl.create(:booking)
      post :create, booking: { user_id: booking.user_id,theater_id: booking.theater_id,show_time_id: booking.show_time_id },format: 'json'
      assigns(:booking).theater_id.should eq booking.theater_id
      assigns(:booking).user_id.should eq booking.user_id
      assigns(:booking).show_time_id.should eq booking.show_time_id
      response.should have_http_status(:created)
    end

    it 'should not create booking with empty input' do
      post :create, booking: { user_id: nil,theater_id: nil,show_time_id: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create booking with invalid theater_id' do
    	booking = FactoryGirl.create(:booking)
      post :create, booking: { user_id: booking.user_id,theater_id: '1234',show_time_id: booking.show_time_id },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create booking with invalid user_id' do
    	booking = FactoryGirl.create(:booking)
      post :create, booking: { user_id: '12345',theater_id: booking.theater_id,show_time_id: booking.show_time_id },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create booking with invalid show_time_id' do
    	booking = FactoryGirl.create(:booking)
      post :create, booking: { user_id: booking.user_id,theater_id: booking.theater_id,show_time_id: '12345' },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update booking successfully' do
      booking1 = FactoryGirl.create(:booking)
      booking2 = FactoryGirl.create(:booking)
      put :update,id: booking1.id, booking: { user_id: booking2.user_id,theater_id: booking2.theater_id,show_time_id: booking2.show_time_id},format: 'json'
      assigns(:booking).id.should eq booking1.id
      assigns(:booking).theater_id.should eq booking2.theater_id
      assigns(:booking).user_id.should eq booking2.user_id
      assigns(:booking).show_time_id.should eq booking2.show_time_id
      response.should have_http_status(:ok)
    end

    it 'should not update booking with invalid inputs' do
      booking1 = FactoryGirl.create(:booking)
      put :update,id: booking1.id, booking: { number: nil,theater_id: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update booking with invalid theater_id' do
      booking1 = FactoryGirl.create(:booking)
      booking2 = FactoryGirl.create(:booking)
      put :update,id: booking1.id, booking: { user_id: booking2.user_id,theater_id: '1123456',show_time_id: booking2.show_time_id},format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

   	it 'should not update booking with invalid user_id' do
      booking1 = FactoryGirl.create(:booking)
      booking2 = FactoryGirl.create(:booking)
      put :update,id: booking1.id, booking: { user_id: '123456',theater_id: booking2.theater_id,show_time_id: booking2.show_time_id},format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update booking with invalid show_time_id' do
      booking1 = FactoryGirl.create(:booking)
      booking2 = FactoryGirl.create(:booking)
      put :update,id: booking1.id, booking: { user_id: booking2.user_id,theater_id: booking2.theater_id,show_time_id: '123456789'},format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update booking with invalid booking_id' do
      booking = FactoryGirl.create(:booking)
      put :update,id: '12345678', booking: { user_id: booking.user_id,theater_id: booking.theater_id,show_time_id: booking.show_time_id},format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy booking successfully' do
      booking = FactoryGirl.create(:booking)
      delete :destroy, id: booking.id,format: 'json'
      assigns(:booking).should eq booking
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid booking' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
