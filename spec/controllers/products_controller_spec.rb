require 'rails_helper'

describe ProductsController, type: :controller do
  let (:user_admin) { FactoryBot.create(:user_admin) }
  let (:user_standard) { FactoryBot.create(:user) }
  let (:product) { FactoryBot.create(:product) }

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
  end                        #end describe GET #edit

  describe 'GET #index' do
    context 'when no search parameter is passed' do
      it 'renders the index template' do
        get :index
        expect(response).to be_ok
        expect(response).to render_template('index')
      end                       #end it
    end                         #end context

    context 'when a search parameter is passed' do
      it 'renders the index template' do
        get :index, params: { search_term: "1"}
        expect(response).to be_ok
        expect(response).to render_template('index')
      end                       #end it
    end                         #end context

  end                           #end describe GET #index

  describe 'GET #show' do
    context 'when a product is selected' do
      it 'renders the show template' do 
        get :show, params: { id: product.id}
        expect(response).to be_ok
        expect(response).to render_template('show')
      end                       #end it
    end                         #end context
  end                           #end describe GET #show

  describe 'GET #new' do
    context 'when add new product is selected by admin' do
      before(:each) do 
       sign_in user_admin
      end                    # end before
      it 'renders the new product template' do 
        get :new
        expect(response).to render_template('new')
      end                       #end it
    end                         #end context

    context 'when add new product is selected by non-admin' do
      before(:each) do 
       sign_in user_standard
      end                    # end before
      it 'redirects non-admin user to root path' do 
        get :new
        expect(response).to redirect_to(root_path)
      end                       #end it
    end                         #end context

    context 'when user is not logged in' do
      it 'redirects to root path' do 
        get :new
        expect(response).to redirect_to(root_path)
      end                       #end it
    end                         #end context
  end                           #end describe GET #new

  describe '#PATCH/PUT create' do
    context 'when a new product is submitted' do 
      before(:each) do          #only admins can reach this point
       sign_in user_admin
      end                     # end before
      it 'saves the product and redirects to product page' do 
        post :create, params: { product: { name: "test", description: "test", image_url: "test", colour: "test", price: ".01"} }
        expect(response.status).to eq 302
        expect(response).to redirect_to("/products/1")
      end                     #end it
    end                       #end context
  end                         #end describe PATCH/PUT #create

  describe '#PATCH/PUT update' do
    context 'when edited product data is submitted' do 
      before(:each) do          #only admins can reach this point
       sign_in user_admin
      end                     # end before
      it 'saves the product and redirects to product page' do 
        patch :update, params: { id: product.id, product: { name: "test update" } }
        expect(response.status).to eq 302
        expect(response).to redirect_to("/products/1")
      end                     #end it
    end                       #end context
  end                         #end describe PATCH/PUT #update

 describe '#DELETE destroy' do
    context 'when a product is deleted' do 
      before(:each) do          #only admins can reach this point
       sign_in user_admin
      end                     # end before
      it 'deletes the product and redirects to product index' do 
        delete :destroy, params: { id: product.id }
        expect(response.status).to eq 302
        expect(response).to redirect_to("/products")
      end                     #end it
    end                       #end context
  end                         #end describe #DELETE destroy

end                          #end describe ProductsController

