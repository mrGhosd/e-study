# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::RegistrationsController do
  let!(:auth) { create :authorization }

  def user_attributes
    {
      email: 'example@mail.com',
      password: 'password1234',
      password_confirmation: 'password1234',
      authorization: auth.attributes
    }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new user' do
        expect do
          post :create, user: user_attributes
        end.to change(User, :count).by(1)
      end

      it 'create new authorization' do
        post :create, user: user_attributes
        auth.reload
        expect(auth.user_id).to eq(User.last.id)
      end

      it 'return remember token' do
        post :create, user: user_attributes
        auth = Authorization.find_by_jwt_token(JSON.parse(response.body)['token'])
        expect(auth.id).to eq(Authorization.last.id)
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new user' do
        expect do
          post :create, user: {}
        end.to change(User, :count).by(0)
      end

      context 'failure response' do
        before { post :create, user: {} }

        %w(email password).each do |attr|
          it "failure response contain #{attr} attribute" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end
end
