require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	context 'GET#index' do
    it 'should show all users successfully' do
    	user1 = FactoryGirl.create(:user)
    	user2 = FactoryGirl.create(:user)
      get :index, format: 'json'
      assigns(:users).should include user1
      assigns(:users).should include user2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get user successfully' do
      user = FactoryGirl.create(:user)
      get :show, id: user.id, format: 'json'
      assigns(:user).should eq user
      response.should have_http_status(:ok)
    end

    it 'should not get invalid user' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new user successfully' do
      get :new, format: 'json'
      assigns(:user).id.should eq nil
      assigns(:user).name.should eq nil
      assigns(:user).age.should eq nil
      assigns(:user).phone_no.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct user successfully' do
      user = FactoryGirl.create(:user)
      get :edit, id: user.id,format: 'json'
      assigns(:user).should eq user
      response.should have_http_status(:ok)
    end

    it 'should not get user with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create user successfully' do
      user = FactoryGirl.create(:user)
      post :create, user: { name: user.name,age: user.age,phone_no: user.phone_no },format: 'json'
      assigns(:user).name.should eq user.name
      assigns(:user).age.should eq user.age
      assigns(:user).phone_no.should eq user.phone_no
      response.should have_http_status(:created)
    end

    it 'should not create user with invalid inputs' do
      post :create, user: { name: nil,age: nil,phone_no: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update user successfully' do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      put :update,id: user1.id, user: { name: user2.name,age: user2.age,phone_no: user2.phone_no},format: 'json'
      assigns(:user).id.should eq user1.id
      assigns(:user).name.should eq user2.name
      assigns(:user).age.should eq user2.age
      assigns(:user).phone_no.should eq user2.phone_no
      response.should have_http_status(:ok)
    end

    it 'should not update user with invalid inputs' do
      user1 = FactoryGirl.create(:user)
      put :update,id: user1.id, user: { name: nil,age: nil,phone_no: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update user with invalid user' do
      user = FactoryGirl.create(:user)
      put :update,id: '123456', user: { name: user.name,age: user.age,phone_no: user.phone_no },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy user successfully' do
      user = FactoryGirl.create(:user)
      delete :destroy, id: user.id,format: 'json'
      assigns(:user).should eq user
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid user' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
