require 'rails_helper'

RSpec.describe "Api::V1::Comments", type: :request do

  let(:user) { FactoryGirl.create(:user) }
  let(:post_user) {FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:post, user: post_user) }

  describe "GET /posts/:post_id/comments" do
    context "guest user" do
      it "available for user" do
        get api_v1_post_comments_path(blog_post), {}, @env
        expect(response).to have_http_status(200)
      end
    end
    context "registered user" do
      it "available for user" do
        basic_auth(user)
        get api_v1_post_comments_path(blog_post), {}, @env
        expect(response).to have_http_status(200)
      end
    end
  end

  let(:comment)   { FactoryGirl.create(:comment, post: blog_post, user: user) }
  let(:new_comment) { {body: 'new comment body'} }

  describe "GET /posts/:post_id/comments/:id" do
    context "guest user" do
      it "available for user" do
        get api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(200)
      end
    end

    context "registered user" do 
      it "available for user" do
        basic_auth(user)
        get api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST /posts/:post_id/comments" do
    context "guest user" do
      it "not available for user" do
        post api_v1_post_comments_path(blog_post), {comment: new_comment}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do 
      it "available for registered user" do
        basic_auth(user)
        post api_v1_post_comments_path(blog_post), {comment: new_comment}, @env
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "PUTS /posts/:post_id/comments/:id" do
    context "guest user" do
      it "not available for user" do
        put api_v1_post_comment_path(blog_post, comment), {comment: new_comment}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for comment owner user" do
        basic_auth(user)
        put api_v1_post_comment_path(blog_post, comment), {comment: new_comment}, @env
        expect(response).to have_http_status(204)
      end

      it "available for post owner user" do
        basic_auth(post_user)
        put api_v1_post_comment_path(blog_post, comment), {comment: new_comment}, @env
        expect(response).to have_http_status(204)
      end

      it "available for admin user" do
        basic_auth(admin)
        put api_v1_post_comment_path(blog_post, comment), {comment: new_comment}, @env
        expect(response).to have_http_status(204)
      end

      it "not available if user is not post or comment owner or not admin" do
        basic_auth(other_user)
        put api_v1_post_comment_path(blog_post, comment), {comment: new_comment}, @env
        expect(response).to have_http_status(403)
      end
    end
  end

  describe "DELETE /posts/:post_id/comments/:id" do
    context "guest user" do
      it "not available for user" do
        delete api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(401)
      end
    end

    context "registered user" do
      it "available for comment owner" do
        basic_auth(user)
        delete api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(204)
      end

      it "available for post owner" do
        basic_auth(post_user)
        delete api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(204)
      end
      
      it "available for admin" do
        basic_auth(admin)
        delete api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(204)
      end

      it "not available if user is not post or comment owner or not admin" do
        basic_auth(other_user)
        delete api_v1_post_comment_path(blog_post, comment), {}, @env
        expect(response).to have_http_status(403)
      end
    end
  end
end
