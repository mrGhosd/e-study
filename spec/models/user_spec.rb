# frozen_string_literal: true
require 'rails_helper'

describe User do
  let!(:user) { create :user }
  let!(:access_token) { generate_token_for_user(user) }

  describe '#find_by_jwt_token' do
    context 'token exists' do
      it 'return user' do
        expect(User.find_by_jwt_token(access_token)).to eq(user)
      end
    end

    context 'token doesn\'t exists' do
      it 'return nil' do
        expect(User.find_by_jwt_token(nil)).to eq(nil)
      end
    end
  end
end
