require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  let(:valid_attributes) {
    { title: 'title', body: 'text' }
  }

  let(:invalid_attributes) {
    { title: nil}
  }

  let!(:user) {FactoryGirl.create(:user) }
  
  before :each do
    request.accept = "application/json"
    basic_auth(user)
  end

  describe "GET #index" do
    it "assigns all posts as @posts" do
      post = FactoryGirl.create(:post)
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "GET #show" do
    it "assigns the requested post as @post" do
      post = FactoryGirl.create(:post)
      get :show, {:id => post.to_param}
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, {:post => valid_attributes}
        }.to change(Post, :count).by(1)
      end

      it "assigns created post to current user" do
        post :create, {:post => valid_attributes}
        expect(assigns(:post).user).to eq(user)
      end
      
      it "assigns a newly created post as @post" do
        post :create, {:post => valid_attributes}
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        post :create, {:post => invalid_attributes}
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "don't create new post" do
        expect {
          post :create, {:post => invalid_attributes}
        }.not_to change(Post, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_title) { 'new_title' }
      let(:new_attributes) {
        { title: new_title }
      }

      it "updates the requested post" do
        post = FactoryGirl.create(:post, user: user)
        put :update, {:id => post.to_param, :post => new_attributes}
        post.reload
        expect(post.title).to eq(new_title)
      end

      it "assigns the requested post as @post" do
        post = FactoryGirl.create(:post, user: user)
        put :update, {:id => post.to_param, :post => valid_attributes}
        expect(assigns(:post)).to eq(post)
      end
    end

    context "with invalid params" do
      it "assigns the post as @post" do
        post = FactoryGirl.create(:post, user: user)
        put :update, {:id => post.to_param, :post => invalid_attributes}
        expect(assigns(:post)).to eq(post)
      end
      it "doesn't change post" do
        post = FactoryGirl.create(:post, user: user)
        put :update, {:id => post.to_param, :post => invalid_attributes}
        post.reload
        expect(post.title).not_to eq(invalid_attributes[:title])
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = FactoryGirl.create(:post, user: user)
      expect {
        delete :destroy, {:id => post.to_param}
      }.to change(Post, :count).by(-1)
    end
  end
end
