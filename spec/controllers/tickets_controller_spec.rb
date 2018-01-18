require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
	context 'GET#index' do
    it 'should show all tickets successfully' do
    	ticket1 = FactoryGirl.create(:ticket)
    	ticket2 = FactoryGirl.create(:ticket)
      get :index, format: 'json'
      assigns(:tickets).should include ticket1
      assigns(:tickets).should include ticket2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get ticket successfully' do
      ticket = FactoryGirl.create(:ticket)
      get :show, id: ticket.id, format: 'json'
      assigns(:ticket).should eq ticket
      response.should have_http_status(:ok)
    end

    it 'should not get invalid ticket' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new ticket successfully' do
      get :new, format: 'json'
      assigns(:ticket).id.should eq nil
      assigns(:ticket).audi_id.should eq nil
      assigns(:ticket).booking_id.should eq nil
      assigns(:ticket).type_of_seat.should eq nil
      assigns(:ticket).seat_no.should eq nil
      assigns(:ticket).price.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct ticket successfully' do
      ticket = FactoryGirl.create(:ticket)
      get :edit, id: ticket.id,format: 'json'
      assigns(:ticket).should eq ticket
      response.should have_http_status(:ok)
    end

    it 'should not get ticket with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create ticket successfully' do
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { audi_id: ticket.audi_id,booking_id: ticket.booking_id,type_of_seat: ticket.type_of_seat,seat_no: ticket.seat_no,price: ticket.price },format: 'json'
      assigns(:ticket).audi_id.should eq ticket.audi_id
      assigns(:ticket).booking_id.should eq ticket.booking_id
      assigns(:ticket).type_of_seat.should eq ticket.type_of_seat
      assigns(:ticket).seat_no.should eq ticket.seat_no
      assigns(:ticket).price.should eq ticket.price
      response.should have_http_status(:created)
    end

    it 'should not create ticket with invalid inputs' do
      post :create, ticket: { audi_id: nil,booking_id: nil,type_of_seat: nil,seat_no: nil,price: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid audi_id' do
    	ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { audi_id: '12345',booking_id: ticket.booking_id,type_of_seat: ticket.type_of_seat,seat_no: ticket.seat_no,price: ticket.price },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid booking_id' do
    	ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { audi_id: ticket.audi_id,booking_id: '12345',type_of_seat: ticket.type_of_seat,seat_no: ticket.seat_no,price: ticket.price },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update ticket successfully' do
      ticket1 = FactoryGirl.create(:ticket)
      ticket2 = FactoryGirl.create(:ticket)
      post :update, id: ticket1.id, ticket: { audi_id: ticket2.audi_id,booking_id: ticket2.booking_id,type_of_seat: ticket2.type_of_seat,seat_no: ticket2.seat_no,price: ticket2.price },format: 'json'
      assigns(:ticket).id.should eq ticket1.id
      assigns(:ticket).audi_id.should eq ticket2.audi_id
      assigns(:ticket).booking_id.should eq ticket2.booking_id
      assigns(:ticket).type_of_seat.should eq ticket2.type_of_seat
      assigns(:ticket).seat_no.should eq ticket2.seat_no
      assigns(:ticket).price.should eq ticket2.price
      response.should have_http_status(:ok)
    end

    it 'should not update ticket with invalid inputs' do
      ticket1 = FactoryGirl.create(:ticket)
      put :update,id: ticket1.id, ticket: { audi_id: nil,booking_id: nil,type_of_seat: nil,seat_no: nil,price: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid ticket' do
      ticket = FactoryGirl.create(:ticket)
      put :update,id: '123456', ticket: { audi_id: ticket.audi_id,booking_id: ticket.booking_id,type_of_seat: ticket.type_of_seat,seat_no: ticket.seat_no,price: ticket.price },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid audi' do
      ticket1 = FactoryGirl.create(:ticket)
      ticket2 = FactoryGirl.create(:ticket)
      put :update,id: ticket1.id, ticket: { audi_id: '123456',booking_id: ticket2.booking_id,type_of_seat: ticket2.type_of_seat,seat_no: ticket2.seat_no,price: ticket2.price },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid booking' do
      ticket1 = FactoryGirl.create(:ticket)
      ticket2 = FactoryGirl.create(:ticket)
      put :update,id: ticket1.id, ticket: { audi_id: ticket2.audi_id,booking_id: '12345678',type_of_seat: ticket2.type_of_seat,seat_no: ticket2.seat_no,price: ticket2.price },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy ticket successfully' do
      ticket = FactoryGirl.create(:ticket)
      delete :destroy, id: ticket.id,format: 'json'
      assigns(:ticket).should eq ticket
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid ticket' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
