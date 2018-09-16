require "rails_helper"

RSpec.describe IssuesController, type: :request do
  let(:current_user) { create(:user, :admin) }
  let(:access_token) { prepare_access_token_from(current_user) }
  let(:headers) do
    { "Authorization": "Bearer #{access_token}" }
  end

  def assert_issue(json, issue) # rubocop:disable Metrics/AbcSize
    expect(json["id"]).to eq issue.id
    expect(json["subject"]).to eq issue.subject
    expect(json["description"]).to eq issue.description
    expect(json["comments_count"]).to eq issue.comments_count
    expect(json["likes_count"]).to eq issue.likes_count
    expect(json["created_at"]).to eq issue.created_at.as_json
    expect(json["updated_at"]).to eq issue.updated_at.as_json

    if json["user"]
      expect(json["user"]["id"]).to eq issue.user_id
    else
      expect(json["user"]).to be_nil
    end
  end

  describe "GET /issues" do
    context "when issues are blank" do
      it "returns 200" do
        get "/issues"

        expect(response.status).to eq 200
        expect(json["data"]).to be_empty
        assert_schema_conform
      end
    end

    context "when issues are present" do
      it "returns 200" do
        issues = create_list(:issue, 5)
        get "/issues?sort=oldest"
        expect(response.status).to eq 200
        expect(json["data"]).not_to be_empty
        issues.each_with_index {|issue, i| assert_issue(json["data"][i], issue) }
        assert_schema_conform
      end
    end
  end

  describe "POST /issues" do
    before { post "/issues", params: params, headers: headers }

    context "with admin given valid params" do
      let(:params) do
        {
          issue: {
            subject: Faker::Lorem.sentence,
            description: Faker::Lorem.paragraph,
            secret: true,
          },
        }
      end

      it "returns 201" do
        expect(response.status).to eq 201
        expect(json["subject"]).to eq params.dig(:issue, :subject)
        expect(json["description"]).to eq params.dig(:issue, :description)
        expect(json["user"]).to be_nil
      end
    end

    context "with admin given invalid params" do
      let(:params) do
        {
          issue: {
            subject: "",
            description: "",
            secret: false,
          },
        }
      end

      it "returns 400" do
        expect(response.status).to eq 400
      end
    end

    context "with guest" do
      let(:params) { {} }
      let(:current_user) { create(:user, :guest) }

      it "returns 403" do
        expect(response.status).to eq 403
      end
    end
  end

  describe "GET /issues/:id" do
    context "when resource is blank" do
      it "returns 404" do
        get "/issues/12345"
        expect(response.status).to eq 404
        assert_schema_conform
      end
    end

    context "when resource is present" do
      let(:issue) { create(:issue, secret: true) }

      it "returns 200" do
        get "/issues/#{issue.id}"

        expect(response.status).to eq 200
        assert_issue(json, issue)
        assert_schema_conform
      end
    end
  end

  describe "PUT /issues/:id" do
    let(:issue) { create(:issue) }

    before { put "/issues/#{issue.id}", params: params, headers: headers }

    context "with admin given valid params" do
      let(:params) do
        {
          issue: {
            subject: Faker::Lorem.sentence,
            description: Faker::Lorem.paragraph,
            secret: false,
          },
        }
      end

      it "returns 200" do
        expect(response.status).to eq 200
        expect(json["id"]).to eq issue.id
        expect(json["subject"]).to eq params.dig(:issue, :subject)
        expect(json["description"]).to eq params.dig(:issue, :description)
      end
    end

    context "with admin given invalid params" do
      let(:params) do
        {
          issue: {
            subject: "",
            description: "",
            secret: false,
          },
        }
      end

      it "returns 400" do
        expect(response.status).to eq 400
      end
    end

    context "with guest" do
      let(:params) { {} }
      let(:current_user) { create(:user, :guest) }

      it "returns 403" do
        expect(response.status).to eq 403
      end
    end
  end

  describe "DELETE /issues/:id" do
    let(:issue) { create(:issue) }

    before { delete "/issues/#{issue.id}", headers: headers }

    context "with admin" do
      it "returns 200" do
        expect(response.status).to eq 200
      end
    end

    context "with guest" do
      let(:current_user) { create(:user, :guest) }

      it "returns 403" do
        expect(response.status).to eq 403
      end
    end
  end
end
