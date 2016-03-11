require 'rails_helper'

describe Api::V0::UsersController do
  let!(:user) { create :user }
  let!(:user_attributes) do
    {
      email: user.email,
      first_name: 'Example',
      last_name: 'Example',
      middle_name: 'date',
      date_of_birth: Time.zone.today.to_s
    }
  end

  describe 'GET #index' do
    it 'render users list' do
      get :index
      expect(JSON.parse(response.body)).to have_key('users')
    end
  end

  describe 'GET #show' do
    it 'render user info' do
      get :show, id: user.id
      expect(JSON.parse(response.body)).to have_key('user')
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'update user info' do
        put_with_token user, :update, id: user.id, user: user_attributes
        user.reload
        expect(user.first_name).to eq(user_attributes[:first_name])
      end

      it 'render user item' do
        put_with_token user, :update, id: user.id, user: user_attributes
        expect(JSON.parse(response.body)).to have_key('user')
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update user data' do
        put_with_token user, :update, id: user.id, user: {}
        user.reload
        expect(user.first_name).to eq(nil)
      end

      context 'failure response' do
        before { put_with_token user, :update, id: user.id, user: {} }

        %w(email first_name last_name middle_name date_of_birth).each do |attr|
          it "failure resposne contain #{attr}" do
            expect(JSON.parse(response.body)).to have_key(attr)
          end
        end
      end
    end
  end
end
