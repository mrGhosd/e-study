require 'rails_helper'

describe Api::V0::SessionsController, type: :controller do

  describe 'POST #create' do
    let!(:user) { create :user }

    context 'with valid attributes' do
      let!(:access_token) { generate_token_for_user(user) }

      context 'check remember token' do
        before do
          allow(JWT).to receive(:encode).and_return(access_token)
          post :create, session: { email: user.email, password: user.password }, format: :json
        end

        it 'response have a jwt token' do
          expect(JSON.parse(response.body)).to have_key('remember_token')
        end

        it 'generate jwt token' do
          expect(JSON.parse(response.body)['remember_token']).to eq(access_token)
        end
      end

      context 'check jwt' do
        before do
          post :create,
               session: { email: user.email, password: user.password },
               format: :json
        end

        it 'cypher user data in token' do
          token = JSON.parse(response.body)['remember_token']
          cypher_user = JWT.decode(token, Rails.application.secrets.jwt_secret).first
          expect(cypher_user['id']).to eq(user.id)
        end
      end

      context 'current user' do
        before do
          post :create, session: { email: user.email, password: user.password }, format: :json
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
            post :create, session: { email: user.email, password: user.password }, format: :json
          end.to raise_error('unauthorized error')
        end
      end
    end
  end
end
