require "rails_helper"

RSpec.describe AuthenticationsController, type: :request do
  describe "GET /auth/github" do
    it "returns 302" do
      get "/auth/github"
      expect(response.status).to eq 302
    end
  end

  describe "GET /auth/github/callback" do
    let(:user) { create(:user) }

    before do
      prepare_mock_auth_from(user)
      get "/auth/github/callback"
    end

    it "returns 200" do
      expect(response.status).to eq 200
      expect(response.content_type).to eq "text/html"
    end
  end
end
