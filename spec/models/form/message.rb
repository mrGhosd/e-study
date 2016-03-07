require 'rails_helper'

describe Form::Message do
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
      'users' => [first_user, second_user].map(&:id)
    }
  end

  describe 'submit' do
    context 'with valid attributes' do
      let!(:form) do
        ::Form::Message.new(
          first_user.messages.build(chat_id: message_attributes['chat_id']),
          message_attributes
        )
      end

      it 'create new message' do
        expect do
          form.submit
        end.to change(Message, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      def message_attributes
        {
          'text' => nil,
          'user_id' => second_user.id,
          'chat_id' => chat.id,
          'users' => [first_user, second_user].map(&:id)
        }
      end

      let!(:form) do
        ::Form::Message.new(
          first_user.messages.build(chat_id: message_attributes['chat_id']),
          message_attributes
        )
      end

      it 'doesn\'t create a new message' do
        expect { form.submit }.to change(::Message, :count).by(0)
      end

      context 'failure message' do
        before { form.submit }

        it 'form error contain `text` attribute' do
          expect(form.errors.messages).to have_key(:text)
        end
      end
    end

    context 'chat doesn\' exists' do
      def message_attributes
        {
          'text' => 'example',
          'user_id' => second_user.id,
          'chat_id' => nil,
          'users' => [first_user, second_user].map(&:id)
        }
      end

      it 'create new chat' do
        expect do
          ::Form::Message.new(
            first_user.messages.build(chat_id: message_attributes['chat_id']),
            message_attributes
          )
        end.to change(Chat, :count).by(1)
      end

      it 'create new user_chat by numbers of users' do
        expect do
          ::Form::Message.new(
            first_user.messages.build(chat_id: message_attributes['chat_id']),
            message_attributes
          )
        end.to change(UserChat, :count).by(message_attributes['users'].length)
      end
    end

    context 'message has attaches' do
      let!(:file) do
        Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'app', 'assets', 'images', 'test.jpg')
        )
      end

      let!(:attach) do
        create :attach, file: file,
                        attachable_type: 'Message',
                        type: 'Image'
      end

      def attach_params
        {
          'id' => attach.id,
          'file' => file,
          'attachable_type' => attach.attachable_type,
          'type' => attach.type
        }
      end

      before { @attrs = message_attributes.merge!('attaches' => [attach_params]) }

      it 'create new attach to mesage' do
        form = ::Form::Message.new(
          first_user.messages.build(chat_id: @attrs['chat_id']),
          @attrs
        )
        form.submit
        expect(attach.reload.attachable_id).to eq(Message.last.id)
      end
    end
  end
end
