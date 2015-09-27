class ChatsController < ApplicationController
  def index
    chats = current_user.chats
    render json: chats
  end

  def show
    chat = Chat.find(params[:id])
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