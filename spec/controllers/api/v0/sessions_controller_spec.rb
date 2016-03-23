require 'rails_helper'

describe Api::V0::SessionsController, type: :controller do

  describe 'POST #create' do
    let!(:user) { create :user }
    let!(:auth) { create :authorization, user_id: user.id }
    let!(:user_attrs) do
      {
        email: user.email,
        password: user.password,
        authorization: auth.attributes
      }
    end

    context 'with valid attributes' do
      let!(:access_token) { generate_token_for_auth(auth) }

      context 'check remember token' do
        before do
          post :create, session: user_attrs, format: :json
        end

        it 'response have a jwt token' do
          expect(JSON.parse(response.body)).to have_key('token')
        end

        it 'generate jwt token' do
          expect(JSON.parse(response.body)['token']).to eq(access_token)
        end
      end

      context 'check jwt' do
        before do
          post :create,
               session: user_attrs,
               format: :json
        end

        it 'cypher user data in token' do
          token = JSON.parse(response.body)['token']
          cypher_user = JWT.decode(token, Rails.application.secrets.jwt_secret).first
          expect(cypher_user['id']).to eq(auth.id)
        end
      end

      context 'current user' do
        before do
          post :create, session: user_attrs, format: :json
        end
      end
    end

    context 'wtih invalid attributes' do
      context 'remember token decoding failed' do
        before do
          allow(JWT).to receive(:encode).and_raise('unauthorized error')
        end

        it 'return 401 status' do
          expect do
            post :create, session: user_attrs, format: :json
          end.to raise_error('unauthorized error')
        end
      end
    end
  end
end
