require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /posts/:id/comments" do
    it "works! (now write some real specs)" do
      get api_v1_post_comments_path(1)
      expect(response).to have_http_status(200)
    end
  end
end
