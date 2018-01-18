require 'rails_helper'

RSpec.describe TheatersController, type: :controller do
	context 'GET#index' do
    it 'should show all theaters successfully' do
    	theater1 = FactoryGirl.create(:theater)
    	theater2 = FactoryGirl.create(:theater)
      get :index, format: 'json'
      assigns(:theaters).should include theater1
      assigns(:theaters).should include theater2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get theater successfully' do
      theater = FactoryGirl.create(:theater)
      get :show, id: theater.id, format: 'json'
      assigns(:theater).should eq theater
      response.should have_http_status(:ok)
    end

    it 'should not get invalid theater' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new theater successfully' do
      get :new, format: 'json'
      assigns(:theater).id.should eq nil
      assigns(:theater).name.should eq nil
      assigns(:theater).address.should eq nil
      assigns(:theater).phone_no.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct theater successfully' do
      theater = FactoryGirl.create(:theater)
      get :edit, id: theater.id,format: 'json'
      assigns(:theater).should eq theater
      response.should have_http_status(:ok)
    end

    it 'should not get theater with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create theater successfully' do
      theater = FactoryGirl.create(:theater)
      post :create, theater: { name: theater.name,address: theater.address,phone_no: theater.phone_no },format: 'json'
      assigns(:theater).name.should eq theater.name
      assigns(:theater).address.should eq theater.address
      assigns(:theater).phone_no.should eq theater.phone_no
      response.should have_http_status(:created)
    end

    it 'should not create theater with invalid inputs' do
      post :create, theater: { name: nil,address: nil,phone_no: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update theater successfully' do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      put :update,id: theater1.id, theater: { name: theater2.name,address: theater2.address,phone_no: theater2.phone_no},format: 'json'
      assigns(:theater).id.should eq theater1.id
      assigns(:theater).name.should eq theater2.name
      assigns(:theater).address.should eq theater2.address
      assigns(:theater).phone_no.should eq theater2.phone_no
      response.should have_http_status(:ok)
    end

    it 'should not update theater with invalid inputs' do
      theater1 = FactoryGirl.create(:theater)
      put :update,id: theater1.id, theater: { name: nil,address: nil,phone_no: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update theater with invalid theater' do
      theater = FactoryGirl.create(:theater)
      put :update,id: '123456', theater: { name: theater.name,address: theater.address,phone_no: theater.phone_no },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy theater successfully' do
      theater = FactoryGirl.create(:theater)
      delete :destroy, id: theater.id,format: 'json'
      assigns(:theater).should eq theater
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid theater' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
