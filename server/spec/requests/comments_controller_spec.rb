require "rails_helper"

RSpec.describe CommentsController, type: :request do
  let(:current_user) { create(:user, :guest) }
  let(:access_token) { prepare_access_token_from(current_user) }
  let(:headers) do
    { "Authorization": "Bearer #{access_token}" }
  end

  def assert_comment(json, comment) # rubocop:disable Metrics/AbcSize
    expect(json["id"]).to eq comment.id
    expect(json["issue_id"]).to eq comment.issue_id
    expect(json["content"]).to eq comment.content
    expect(json["likes_count"]).to eq comment.likes_count

    if json["user"]
      expect(json["user"]["id"]).to eq comment.user_id
    else
      expect(json["user"]).to be_nil
    end
  end

  describe "GET /comments" do
    context "when comments are blank" do
      it "returns 200" do
        get "/comments"

        expect(response.status).to eq 200
        expect(json["data"]).to be_empty
        assert_schema_conform
      end
    end

    context "when comments are present" do
      it "returns 200" do
        comments = create_list(:comment, 5)
        get "/comments?sort=oldest"
        expect(response.status).to eq 200
        expect(json["data"]).not_to be_empty
        comments.each_with_index {|comment, i| assert_comment(json["data"][i], comment) }
        assert_schema_conform
      end
    end
  end

  describe "POST /comments" do
    let(:issue) { create(:issue) }

    before { post "/comments", params: params, headers: headers }

    context "with admin given valid params" do
      let(:params) do
        {
          comment: {
            issue_id: issue.id,
            content: Faker::Lorem.paragraph,
            secret: true,
          },
        }
      end

      it "returns 201" do
        expect(response.status).to eq 201
        expect(json["issue_id"]).to eq params.dig(:comment, :issue_id)
        expect(json["content"]).to eq params.dig(:comment, :content)
        expect(json["user"]).to be_nil
      end
    end

    context "with admin given invalid params" do
      let(:params) do
        {
          comment: {
            issue_id: "",
            content: "",
            secret: false,
          },
        }
      end

      it "returns 400" do
        expect(response.status).to eq 400
      end
    end
  end

  describe "GET /comments/:id" do
    context "when resource is blank" do
      it "returns 404" do
        get "/comments/12345"
        expect(response.status).to eq 404
        assert_schema_conform
      end
    end

    context "when resource is present" do
      let(:comment) { create(:comment) }

      it "returns 200" do
        get "/comments/#{comment.id}"

        expect(response.status).to eq 200
        assert_comment(json, comment)
        assert_schema_conform
      end
    end
  end

  describe "PUT /comments/:id" do
    let(:comment) { create(:comment, user: user) }

    before { put "/comments/#{comment.id}", params: params, headers: headers }

    context "with owner given valid params" do
      let(:user) { current_user }
      let(:params) do
        {
          comment: {
            issue_id: comment.issue_id,
            content: Faker::Lorem.paragraph,
            secret: false,
          },
        }
      end

      it "returns 200" do
        expect(response.status).to eq 200
        expect(json["id"]).to eq comment.id
        expect(json["content"]).to eq params.dig(:comment, :content)
      end
    end

    context "with owner given invalid params" do
      let(:user) { current_user }
      let(:params) do
        {
          comment: {
            issue_id: comment.issue_id,
            content: "",
            secret: false,
          },
        }
      end

      it "returns 400" do
        expect(response.status).to eq 400
      end
    end

    context "without owner" do
      let(:user) { create(:user) }
      let(:params) do
        {}
      end

      it "returns 403" do
        expect(response.status).to eq 403
      end
    end
  end

  describe "DELETE /comments/:id" do
    let(:comment) { create(:comment, user: user) }

    before { delete "/comments/#{comment.id}", headers: headers }

    context "with owner" do
      let(:user) { current_user }

      it "returns 200" do
        expect(response.status).to eq 200
      end
    end

    context "without owner" do
      let(:user) { create(:user) }

      it "returns 403" do
        expect(response.status).to eq 403
      end
    end
  end
end
