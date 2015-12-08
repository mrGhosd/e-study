class Api::V0::ChatsController < Api::ApiController
  def index
    chats = Chat.all
    render json: chats
  end

  def show
    chat = Chat.find(params[:id])
    render json: chat
  end

  def create
    form = Form::Chat.new(Chat.new, params[:chat])
    if form.submit
      render json: form.object
    else
      render json: form.errors
    end
  end
end
