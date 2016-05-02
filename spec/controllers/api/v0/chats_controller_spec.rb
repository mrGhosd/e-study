require 'rails_helper'

describe Api::V0::ChatsController do
  let!(:user) { create :user }
  let!(:another_user) { create :user }
  let!(:auth) { create :authorization, user_id: user.id }

  describe 'GET #index' do
    let!(:chat) { create :chat }
    let!(:user_chat) { create :user_chat, user_id: user.id, chat_id: chat.id }
    let!(:other_user_chat) { create :user_chat, user_id: another_user.id, chat_id: chat.id }
    let!(:message) { create :message, user_id: user.id, chat_id: chat.id }

    context 'success response' do
      before { get_with_token auth, :index }

      %w(messages users).each do |attr|
        it "chat item contatins #{attr}" do
          expect(JSON.parse(response.body)['chats'].first).to have_key(attr)
        end
      end
    end
  end

  describe 'GET #show' do
    let!(:chat) { create :chat }
    let!(:user_chat) { create :user_chat, user_id: user.id, chat_id: chat.id }
    let!(:other_user_chat) { create :user_chat, user_id: another_user.id, chat_id: chat.id }
    let!(:message) { create :message, user_id: user.id, chat_id: chat.id }

    context 'success response' do
      before { get_with_token auth, :index, id: chat.id }

      %w(messages users).each do |attr|
        it "chat item contatins #{attr}" do
          expect(JSON.parse(response.body)['chats'].first).to have_key(attr)
        end
      end
    end
  end

  describe 'POST #create' do
    def chat_params
      {
        users: [user, another_user].map(&:id),
        message: 'example'
      }
    end

    context 'with valid attributes' do
      it 'create new chat' do
        expect do
          post_with_token auth, :create, chat: chat_params
        end.to change(Chat, :count).by(1)
      end

      context 'success response' do
        before { post_with_token auth, :create, chat: chat_params }

        %w(users messages).each do |attr|
          it "success respnse contain #{attr}" do
            expect(JSON.parse(response.body)['chats']).to have_key(attr)
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new chat' do
        expect do
          post_with_token auth, :create, chat: {}
        end.to change(Chat, :count).by(0)
      end

      context 'failed response' do
        before { post_with_token auth, :create, chat: {} }

        %w(message).each do |attr|
          it "failed respnse contain #{attr}" do
            expect(JSON.parse(response.body)).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:chat) { create :chat }
    let!(:user_chat) { create :user_chat, user_id: user.id, chat_id: chat.id, active: true }
    let!(:other_user_chat) { create :user_chat, user_id: another_user.id, chat_id: chat.id }

    it 'update user_chat active attribute' do
      delete_with_token auth, :destroy, id: chat.id
      user_chat.reload
      expect(user_chat.active).to eq(false)
    end
  end
end
