require 'rails_helper'

describe Form::Chat do
  let!(:first_user) { create :user }
  let!(:second_user) { create :user }

  def chat_params
    {
      'users' => [first_user, second_user].map(&:id),
      'message' => 'Example'
    }
  end

  describe 'submit' do
    context 'with valid attrirbutes' do
      let!(:form) { ::Form::Chat.new(Chat.new, chat_params) }

      it 'creates new chat' do
        expect { form.submit }.to change(Chat, :count).by(1)
      end

      it 'create user_chat for every user in chat' do
        expect { form.submit }.to change(UserChat, :count).by(chat_params['users'].length)
      end

      it 'change message count' do
        expect { form.submit }.to change(Message, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Chat.new(Chat.new, {}) }

      it 'doesn\'t creates new chat' do
        expect { form.submit }.to change(Chat, :count).by(0)
      end

      context 'failed response' do
        before { form.submit }

        it 'error message have `message` attribute' do
          expect(form.errors.messages).to have_key(:message)
        end
      end
    end

    context 'user chat already been created' do
      let!(:chat) { create :chat }
      let!(:first_user_chat) do
        create :user_chat, chat_id: chat.id, user_id: first_user.id, active: false
      end

      let!(:second_user_chat) do
        create :user_chat, chat_id: chat.id, user_id: second_user.id
      end

      let!(:form) { ::Form::Chat.new(Chat.new, chat_params) }

      it 'update first user_chat' do
        expect(first_user_chat.reload.active).to eq(true)
      end
    end
  end
end
