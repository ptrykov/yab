require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:other_user) { FactoryGirl.create(:user) }

  describe "GET /users" do
    context "guest user" do
      it "available for user" do
        get api_v1_users_path, {}, @env
        expect(response).to have_http_status(200)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        get api_v1_users_path, {}, @env
        expect(response).to have_http_status(200)
      end
    end 
  end

  describe "GET /users/:id" do

    context "guest user" do
      it "available for user" do
        get api_v1_user_path(other_user), {}, @env
        expect(response).to have_http_status(200)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        get api_v1_user_path(other_user), {}, @env
        expect(response).to have_http_status(200)
      end
    end 
  end

  let(:new_user) { { firstname: 'Ivan', lastname: 'Drago', email: 'ivan@ussr.com', password: 'qwerty123', password_confirmation: 'qwerty123' } }
  describe "POST /users" do

    context "guest user" do
      it "available for user" do
        post api_v1_users_path, {user: new_user}
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "PUTS /users/:id" do
    context "guest user" do
      it "not available for user" do
        put api_v1_user_path(other_user), {user: new_user}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for owner user" do
        basic_auth(user)
        put api_v1_user_path(user), {user: new_user}, @env
        expect(response).to have_http_status(204)
      end

      it "not available if user is not user owner" do
        basic_auth(user)
        put api_v1_user_path(other_user), {user: new_user}, @env
        expect(response).to have_http_status(403)
      end

      it "available for admin user" do
        basic_auth(admin)
        put api_v1_user_path(user), {user: new_user}, @env
        expect(response).to have_http_status(204)
      end

    end
  end

  describe "DELETE /user/:id" do
    context "guest user" do
      it "not available for user" do
        delete api_v1_user_path(user), {}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for owner user" do
        basic_auth(user)
        delete api_v1_user_path(user), {}, @env
        expect(response).to have_http_status(204)
      end

      it "not available if user is not user owner" do
        basic_auth(user)
        delete api_v1_user_path(other_user), {}, @env
        expect(response).to have_http_status(403)
      end

      it "available for admin user" do
        basic_auth(admin)
        delete api_v1_user_path(user), {}, @env
        expect(response).to have_http_status(204)
      end
    end
  end

end
