class Api::V0::ChatsController < Api::ApiController
  before_action :validate_token

  def index
    chats = current_user.chats.active
    render json: chats, each_serializer: ChatsSerializer
  end

  def show
    chat = current_user.chats.active.find(params[:id])
    render json: chat, serializer: ChatsSerializer
  end

  def create
    form = Form::Chat.new(Chat.new, params[:chat])
    if form.submit
      render json: form.object
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user_chat = current_user.user_chats.find_by(chat_id: params[:id])
    if user_chat.update(active: false)
      render json: {user_chat: user_chat}
    else
      render json: {user_chat: user_chat.errors}
    end
  end
end
