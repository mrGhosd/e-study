class Api::V0::ChatsController < Api::ApiController
  before_action :validate_token
  before_action :add_current_user_to_chat, only: :create
  def index
    chats = current_user.chats
    render json: chats
  end

  def show
    chat = current_user.chats.find(params[:id])
    render json: chat
  end

  def create
    form = Form::Chat.new(Chat.new, params[:chat])
    if form.submit
      render json: form.object, serializer: ChatsSerializer
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def add_current_user_to_chat
    params[:chat][:users] << current_user.id
  end
end
