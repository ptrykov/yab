require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe "GET /posts" do
    
    let!(:user) { FactoryGirl.create(:user) }

    it "available for guest user" do
      basic_auth(user)
      get api_v1_posts_path, {}, @env
      expect(response).to have_http_status(200)
    end
  end
end
