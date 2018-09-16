require "rails_helper"

RSpec.describe UsersController, type: :request do
  def assert_user(json, user) # rubocop:disable Metrics/AbcSize
    expect(json["id"]).to eq user.id
    expect(json["nickname"]).to eq user.nickname
    expect(json["comments_count"]).to eq user.comments_count
    expect(json["likes_count"]).to eq user.likes_count
    expect(json["created_at"]).to eq user.created_at.as_json
    expect(json["updated_at"]).to eq user.updated_at.as_json

    if user.image_url
      expect(json["avatar_url"]).to start_with("/rails/active_storage/blobs")
    else
      expect(json["avatar_url"]).to be_nil
    end
  end

  describe "GET /users" do
    context "when users are blank" do
      it "returns 200" do
        get "/users"

        expect(response.status).to eq 200
        expect(json["data"]).to be_empty
        assert_schema_conform
      end
    end

    context "when users are present" do
      it "returns 200" do
        resources = create_list(:user, 5).sort_by {|user| - user.id }
        get "/users"
        expect(response.status).to eq 200
        expect(json["data"]).not_to be_empty
        resources.each_with_index {|user, i| assert_user(json["data"][i], user) }
        assert_schema_conform
      end
    end
  end

  describe "GET /users/:id" do
    context "when resource is blank" do
      it "returns 404" do
        get "/users/12345"
        expect(response.status).to eq 404
        assert_schema_conform
      end
    end

    context "when resource is present" do
      let(:user) { create(:user, image_url: "https://dummyimage.com/100x100/000000/fff.png") }

      it "returns 200" do
        get "/users/#{user.id}"

        expect(response.status).to eq 200
        assert_user(json, user)
        assert_schema_conform
      end
    end
  end
end
