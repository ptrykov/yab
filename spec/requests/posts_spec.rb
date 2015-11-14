require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET /posts" do
    context "guest user" do
      it "available for user" do
        get api_v1_posts_path, {}, @env
        expect(response).to have_http_status(200)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        get api_v1_posts_path, {}, @env
        expect(response).to have_http_status(200)
      end
    end 
  end

 let!(:blog_post) { FactoryGirl.create(:post, user: user) } 
 let(:new_post) { {title: "new_title", body: "new_body"} }

  describe "GET /posts/1" do

    context "guest user" do
      it "available for user" do
        get api_v1_posts_path, {post: blog_post}, @env
        expect(response).to have_http_status(200)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        get api_v1_posts_path, {post: blog_post}, @env
        expect(response).to have_http_status(200)
      end
    end 
  end

  describe "POST /posts" do

    context "guest user" do
      it "available for user" do
        post api_v1_posts_path, {post: new_post}
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        post api_v1_posts_path, {post: new_post}, @env
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "PUTS /posts/1" do
    context "guest user" do
      it "available for user" do
        put api_v1_post_path(blog_post), {post: new_post}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        put api_v1_post_path(blog_post), {post: new_post}, @env
        expect(response).to have_http_status(204)
      end
    end
  end

  describe "DELETE /posts/1" do
    context "guest user" do
      it "available for user" do
        delete api_v1_post_path(blog_post), {}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for user" do
        basic_auth(user)
        delete api_v1_post_path(blog_post), {}, @env
        expect(response).to have_http_status(204)
      end
    end
  end

end
