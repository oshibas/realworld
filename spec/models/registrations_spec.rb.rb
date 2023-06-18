require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "POST /api/users" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            username: "Jacob",
            email: "jake@jake.jake",
            password: "jakejake"
          }
        }
      end

      it "creates a new user" do
        post "/api/users", params: valid_params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to include("user")
        expect(response.body).to include("email")
        expect(response.body).to include("username")
        expect(response.body).to include("id")
        expect(response.body).not_to include("password")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            username: "Jacob",
            email: "invalid_email",
            password: "jakejake"
          }
        }
      end

      it "returns an error" do
        post "/api/users", params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to include("errors")
        expect(response.body).to include("email")
      end
    end
  end
end
