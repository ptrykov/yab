require 'rails_helper'
require 'airborne'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  let(:valid_attributes) {
    { firstname: 'Ivan', lastname: 'Drago', email: 'ivan@ussr.com', password: 'qwerty123', password_confirmation: 'qwerty123' }
  }

  let(:invalid_attributes) {
    { title: nil, lastname: 'Whitney', email: 'john@gmail.com', password: 'qwerty12', password_confirmation: 'qwerty123'}
  }

  before :each do
    request.accept = "application/json"
  end
  
  describe "GET #index" do
    it "assigns all users as @users" do
      get :index, {}
      expect(assigns(:users)).to eq([user])
      expect_json_keys('users.*', [:id, :firstname, :lastname])
      expect_json('users.?', firstname: user.firstname)
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      get :show, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
      expect_json_keys('user', [:id, :firstname, :lastname])
      expect_json('user', firstname: user.firstname)
    end
  end

  before :each do
    basic_auth(user)
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new User" do
        expect {
          post :create, {:user => valid_attributes}
        }.to change(User, :count).by(1)
        expect_json_keys('user', [:id, :firstname, :lastname])
        expect_json('user', firstname: user.firstname)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        post :create, {:user => invalid_attributes}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "don't create new user" do
        expect {
          post :create, {:user => invalid_attributes}
        }.not_to change(User, :count)
        expect_status(422)
      end
    end
  end


  describe "PUT #update" do
    context "with valid params" do
      let(:firstname) { 'new_firstname' }
      let(:new_attributes) {
        { firstname: firstname }
      }

      it "updates the requested user" do
        put :update, {:id => user.to_param, :user => new_attributes}
        user.reload
        expect(user.firstname).to eq(firstname)
        expect_status(204)
      end

      it "assigns the requested user as @user" do
        put :update, {:id => user.to_param, :user => new_attributes}
        expect(assigns(:user)).to eq(user)
      end
    end

    context "with invalid params" do
      it "assigns the user as @user" do
        put :update, {:id => user.to_param, :user => invalid_attributes}
        expect(assigns(:user)).to eq(user)
      end
      it "doesn't change user" do
        put :update, {:id => user.to_param, :user => invalid_attributes}
        user.reload
        expect(user.firstname).not_to eq(invalid_attributes[:firstname])
        expect_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, {:id => user.to_param}
      }.to change(User, :count).by(-1)
      expect_status(204)
    end
  end
end
