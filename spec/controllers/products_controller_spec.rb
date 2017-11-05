require 'rails_helper'

describe ProductsController, type: :controller do
  let (:user_admin) { User.create!(email: "jtest@email.com", password: "moonstone", admin: "true") }
  let (:user_standard) { User.create!(email: "jtest2@email.com", password: "moonstone") }
  let (:product) { Product.create!(name: "Batman Movie DVD", description: "test", colour: "black", price: 1.00, image_url: "test") }

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


