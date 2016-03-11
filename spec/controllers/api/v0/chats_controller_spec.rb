require 'rails_helper'

describe Api::V0::ChatsController do
  let!(:user) { create :user }
  let!(:another_user) { create :user }
  let!(:chat) { create :chat }
  let!(:user_chat) { create :user_chat, user_id: user.id, chat_id: chat.id }
  let!(:other_user_chat) { create :user_chat, user_id: another_user.id, chat_id: chat.id }
  let!(:message) { create :message, user_id: user.id, chat_id: chat.id }

  describe 'GET #index' do
    context 'success response' do
      before { get_with_token user, :index }

      %w(messages users).each do |attr|
        it "chat item contatins #{attr}" do
          expect(JSON.parse(response.body)['chats'].first).to have_key(attr)
        end
      end
    end
  end

  describe 'GET #show' do
    context 'success response' do
      before { get_with_token user, :index, id: chat.id }

      %w(messages users).each do |attr|
        it "chat item contatins #{attr}" do
          expect(JSON.parse(response.body)['chats'].first).to have_key(attr)
        end
      end
    end
  end

  describe 'POST #create' do

  end

  describe 'DELETE #destroy' do

  end
end
