require 'rails_helper'

describe UsersController, type: :controller do
  let (:user) { User.create!(email: "jtest@email.com", password: "moonstone") }
  let (:user2) { User.create!(email: "jtest2@email.com", password: "moonstone") }
  
  describe 'GET #show' do
    context 'when a user is logged in' do
      before(:each) do 
       sign_in user
      end
      it "loads correct user details" do
        get :show, params: { id: user.id }
        expect(response).to be_ok
        expect(assigns(:user)).to eq user
      end
    end

    context 'when a different user is logged in' do
      before(:each) do
        sign_in user
      end
      it 'redirects to root path' do
         get :show, params: { id: user2.id }     
         expect(response).to redirect_to (root_path)
      end
    end

    context 'when a user is not logged in' do
      it 'redirects to user login page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to (new_user_session_path)
      end
    end

  end

end

