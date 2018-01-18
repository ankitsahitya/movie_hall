require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
	context 'GET#index' do
    it 'should show all movies successfully' do
    	movie1 = FactoryGirl.create(:movie)
    	movie2 = FactoryGirl.create(:movie)
      get :index, format: 'json'
      assigns(:movies).should include movie1
      assigns(:movies).should include movie2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get movie successfully' do
      movie = FactoryGirl.create(:movie)
      get :show, id: movie.id, format: 'json'
      assigns(:movie).should eq movie
      response.should have_http_status(:ok)
    end

    it 'should not get invalid movie' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new movie successfully' do
      get :new, format: 'json'
      assigns(:movie).id.should eq nil
      assigns(:movie).name.should eq nil
      assigns(:movie).category.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct movie successfully' do
      movie = FactoryGirl.create(:movie)
      get :edit, id: movie.id,format: 'json'
      assigns(:movie).should eq movie
      response.should have_http_status(:ok)
    end

    it 'should not get movie with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create movie successfully' do
      movie = FactoryGirl.create(:movie)
      post :create, movie: { name: movie.name,category: movie.category },format: 'json'
      assigns(:movie).name.should eq movie.name
      assigns(:movie).category.should eq movie.category
      response.should have_http_status(:created)
    end

    it 'should not create movie with invalid inputs' do
      post :create, movie: { name: nil,category: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update movie successfully' do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      put :update,id: movie1.id, movie: { name: movie2.name,category: movie2.category },format: 'json'
      assigns(:movie).id.should eq movie1.id
      assigns(:movie).name.should eq movie2.name
      assigns(:movie).category.should eq movie2.category
      response.should have_http_status(:ok)
    end

    it 'should not update movie with invalid inputs' do
      movie1 = FactoryGirl.create(:movie)
      put :update,id: movie1.id, movie: { name: nil,category: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update movie with invalid category' do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      put :update,id: '123456', movie: { name: movie2.name,category: movie2.category },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy movie successfully' do
      movie = FactoryGirl.create(:movie)
      delete :destroy, id: movie.id,format: 'json'
      assigns(:movie).should eq movie
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid movie' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
