require 'rails_helper'

describe Api::V0::SearchController do
  let!(:user) { create :user, first_name: 'aaaaaa' }
  let!(:another_user) { create :user, first_name: 'bbbbbb' }

  describe 'GET #search' do
    it 'return matched user' do
      get :search, object: 'user', query: 'aaaa'
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
