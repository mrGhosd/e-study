require 'rails_helper'

describe Api::V0::MessagesController do
  describe 'POST #create' do
    let!(:first_user) { create :user }
    let!(:second_user) { create :user }
    let!(:chat) { create :chat }
    let!(:first_user_chat) do
      create :user_chat, user_id: first_user.id, chat_id: chat.id, active: true
    end

    def message_attributes
      {
        'text' => 'example',
        'user_id' => second_user.id,
        'chat_id' => chat.id,
        'users' => [second_user].map(&:id)
      }
    end

    context 'with valid attributes' do
      it 'create new message' do
        expect do
          post_with_token first_user, :create, message: message_attributes
        end.to change(Message, :count).by(1)
      end

      context 'success response' do
        before { post_with_token first_user, :create, message: message_attributes }

        %w(id text chat_id user chat).each do |attr|
          it "success message respons contains #{attr}" do
            expect(JSON.parse(response.body)['message']).to have_key(attr)
          end
        end
      end
    end

    context 'with invalid attributes' do
      def message_attributes
        {
          'text' => nil,
          'user_id' => second_user.id,
          'chat_id' => chat.id,
          'users' => [second_user].map(&:id)
        }
      end

      it 'doesn\'t create new message' do
        expect do
          post_with_token first_user, :create, message: message_attributes
        end.to change(Message, :count).by(0)
      end

      context 'failure response' do
        before { post_with_token first_user, :create, message: message_attributes }

        it 'have text key error' do
          expect(JSON.parse(response.body)).to have_key('text')
        end
      end
    end
  end
end
