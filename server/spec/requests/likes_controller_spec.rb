require "rails_helper"

RSpec.describe LikesController, type: :request do
  let(:current_user) { create(:user, :guest) }
  let(:access_token) { prepare_access_token_from(current_user) }
  let(:headers) do
    { "Authorization": "Bearer #{access_token}" }
  end

  describe "POST /like" do
    let(:resource) { create(:comment) }
    let(:params) do
      {
        type: "Comment",
        resource_id: resource.id,
      }
    end

    context "When user post like the resource for the first time" do
      it "returns 201" do
        post "/like", params: params, headers: headers
        expect(response.status).to eq 201
      end
    end

    context "When user have already liked the resource" do
      it "returns 201" do
        post "/like", params: params, headers: headers
        expect(response.status).to eq 201
      end
    end
  end

  describe "DELETE /like" do
    let(:resource) { create(:comment) }
    let(:params) do
      {
        type: "Comment",
        resource_id: resource.id,
      }
    end

    context "When user delete like for the resource" do
      before do
        create(:like, likeable: resource, user: current_user)
      end

      it "returns 200" do
        delete "/like", params: params, headers: headers
        expect(response.status).to eq 200
      end
    end

    context "When user have already deleted like" do
      it "returns 404" do
        delete "/like", params: params, headers: headers
        expect(response.status).to eq 404
      end
    end
  end
end
