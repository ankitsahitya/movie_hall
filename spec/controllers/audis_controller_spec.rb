require 'rails_helper'

RSpec.describe AudisController, type: :controller do
	context 'GET#index' do
    it 'should show all audis successfully' do
    	audi1 = FactoryGirl.create(:audi)
    	audi2 = FactoryGirl.create(:audi)
      get :index, format: 'json'
      assigns(:audis).should include audi1
      assigns(:audis).should include audi2
      response.should have_http_status(:ok)
    end
  end

	context 'GET#show' do
    it 'should get audi successfully' do
      audi = FactoryGirl.create(:audi)
      get :show, id: audi.id, format: 'json'
      assigns(:audi).should eq audi
      response.should have_http_status(:ok)
    end

    it 'should not get invalid audi' do
      get :show, id: '12345', format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'GET#new' do
    it 'should get new audi successfully' do
      get :new, format: 'json'
      assigns(:audi).id.should eq nil
      assigns(:audi).theater_id.should eq nil
      assigns(:audi).number.should eq nil
      response.should have_http_status(:ok)
    end
  end

	context 'GET#edit' do
    it 'should get correct audi successfully' do
      audi = FactoryGirl.create(:audi)
      get :edit, id: audi.id,format: 'json'
      assigns(:audi).should eq audi
      response.should have_http_status(:ok)
    end

    it 'should not get audi with invalid id' do
      get :edit, id: '12345',format: 'json'
      response.should have_http_status(:not_found)
    end
  end

  context 'POST#create' do
    it 'should create audi successfully' do
      audi = FactoryGirl.create(:audi)
      post :create, audi: { number: audi.number,theater_id: audi.theater_id },format: 'json'
      assigns(:audi).number.should eq audi.number
      assigns(:audi).theater_id.should eq audi.theater_id
      response.should have_http_status(:created)
    end

    it 'should not create audi with invalid inputs' do
      post :create, audi: { number: nil,theater_id: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create audi with invalid theater_id' do
      post :create, audi: { number: '4',theater_id: '1234567' },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT#update' do
    it 'should update audi successfully' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      put :update,id: audi1.id, audi: { number: audi2.number,theater_id: audi2.theater_id },format: 'json'
      assigns(:audi).id.should eq audi1.id
      assigns(:audi).number.should eq audi2.number
      assigns(:audi).theater_id.should eq audi2.theater_id
      response.should have_http_status(:ok)
    end

    it 'should not update audi with invalid inputs' do
      audi1 = FactoryGirl.create(:audi)
      put :update,id: audi1.id, audi: { number: nil,theater_id: nil },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update audi with invalid theater_id' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      put :update,id: audi1.id, audi: { number: audi2.number,theater_id: '1234567' },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update audi with invalid audi_id' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      put :update,id: '12345678', audi: { number: audi2.number,theater_id: audi2.theater_id },format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE#destroy' do
    it 'should destroy audi successfully' do
      audi = FactoryGirl.create(:audi)
      delete :destroy, id: audi.id,format: 'json'
      assigns(:audi).should eq audi
      response.should have_http_status(:ok)
    end

    it 'should not destroy invalid audi' do
      delete :destroy, id: '12345',format: 'json'
      response.should have_http_status(:unprocessable_entity)
    end
  end
end
