require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:post, user: user) }

  let(:valid_attributes) {
    { body: 'body_text'}
  }

  let(:invalid_attributes) {
    { body: nil }
  }

  before :each do
    request.accept = "application/json"
    basic_auth(user)
  end

  describe "GET #index" do
    it "assigns only post comments as @comments" do
      comment = FactoryGirl.create(:comment)
      get :index, {:post_id => blog_post.to_param}
      expect(assigns(:comments)).to eq([])
    end

    it "assigns only comments that belongs to post" do
      comment = FactoryGirl.create(:comment)
      post_comment = FactoryGirl.create(:comment, post: blog_post)
      get :index, {:post_id => blog_post.to_param}
      expect(assigns(:comments)).to eq([post_comment])
    end
  end

  describe "GET #show" do
    it "assigns the requested comment as @comment" do
      comment = FactoryGirl.create(:comment)
      get :show, {:post_id => comment.post.to_param, :id => comment.to_param}
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, {:post_id => blog_post.to_param, :comment => valid_attributes}
        }.to change(Comment, :count).by(1)
      end

      it "assigns created comment, to current_user and post" do
        post :create, {:post_id => blog_post.to_param, :comment => valid_attributes}
        expect(assigns(:comment).user).to eq(user)
        expect(assigns(:comment).post).to eq(blog_post)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {:post_id => blog_post.to_param, :comment => valid_attributes}
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, {:post_id => blog_post.to_param, :comment => invalid_attributes}
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "don't create new comment" do
        expect{
          post :create, {:post_id => blog_post.to_param, :comment => invalid_attributes}
        }.not_to change(Comment, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_body) {'new comment body'}
      let(:new_attributes) {
        { body: new_body }
      }

      it "updates the requested comment" do
        comment = FactoryGirl.create(:comment, post: blog_post)
        put :update, {:post_id => blog_post.to_param, :id => comment.to_param, :comment => new_attributes}
        comment.reload
        expect(comment.body).to eq(new_body)
      end

      it "assigns the requested comment as @comment" do
        comment = FactoryGirl.create(:comment, post: blog_post)
        put :update, {:post_id => blog_post.to_param, :id => comment.to_param, :comment => valid_attributes}
        expect(assigns(:comment)).to eq(comment)
      end
    end

    context "with invalid params" do
      it "assigns the comment as @comment" do
        comment = FactoryGirl.create(:comment, post: blog_post)
        put :update, {:post_id => blog_post.to_param, :id => comment.to_param, :comment => invalid_attributes}
        expect(assigns(:comment)).to eq(comment)
      end

      it "doesn't change comment" do
        comment = FactoryGirl.create(:comment, post: blog_post)
        put :update, {:post_id => blog_post.to_param, :id => comment.to_param, :comment => invalid_attributes}
        comment.reload
        expect(comment.body).not_to eq(invalid_attributes[:body])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      comment = FactoryGirl.create(:comment, post: blog_post)
      expect {
        delete :destroy, {:post_id => blog_post.to_param, :id => comment.to_param}
      }.to change(Comment, :count).by(-1)
    end
  end

end
