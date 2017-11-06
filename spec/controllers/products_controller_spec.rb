require 'rails_helper'

describe ProductsController, type: :controller do
  let (:user_admin) { FactoryGirl.create(:user_admin) }
  let (:user_standard) { FactoryGirl.create(:user) }
  let (:product) { FactoryGirl.create(:product) }

  describe 'GET #edit' do
    context 'when admin user is logged in' do 
      before(:each) do 
       sign_in user_admin
      end                    # end before
      it 'permits editing by admin user' do
        get :edit, params: { id: product.id }
        expect(response).to be_ok
        expect(assigns(:product)).to eq product
      end                    # end it
    end                      # end context
    
    context 'when non-admin user is loggged in' do 
      before(:each) do
        sign_in user_standard
      end                    #end before
      it 'redirects non-admin user to root_path' do
        get :edit, params: { id: product.id }
        expect(response).to redirect_to (root_path)
      end                    #end it
    end                      #end context

    context 'when a user is not logged in' do
      it 'redirects to root_path' do
        get :edit, params: { id: product.id }     
        expect(response).to redirect_to (root_path)
      end                    #end it
    end                      #end context
  end                        #end describe
end                          #end describe


