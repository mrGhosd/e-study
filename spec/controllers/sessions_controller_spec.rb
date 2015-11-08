require 'rails_helper'

describe Api::SessionsController, type: :controller do
  describe "POST #create" do
    context "with valid attributes" do
      let!(:user) { create :user }
      let!(:access_token) { Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64) }

      context "check remember token" do
        before do
          allow(JWT).to receive(:encode).and_return(access_token)
          post :create, session: {email: user.email, password: user.password }, format: :json
        end

        it "response have a jwt token" do
          expect(JSON.parse(response.body)).to have_key("remember_token")
        end

        it "generate jwt token" do
          expect(JSON.parse(response.body)["remember_token"]).to eq(access_token)
        end
      end

      context "check jwt" do
        before { post :create, session: {email: user.email, password: user.password }, format: :json }

        it "cypher user data in token" do
          token = JSON.parse(response.body)["remember_token"]
          cypher_user = JWT.decode(token, 'secret').first
          expect(cypher_user["id"]).to eq(user.id)
        end
      end
    end

    context "wtih invalid attributes" do

    end
  end
end