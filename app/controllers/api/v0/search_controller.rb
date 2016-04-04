class Api::V0::SearchController < Api::ApiController
  before_action :validate_token, except: :search

  def search
    form = Form::Search.new(nil, params)
    render json: form.search
  end

  def chats
    form = Form::Search.new(current_user, params)
    render json: form.search_chats, each_serializer: ChatsSerializer
  end

  def messages
  end
end
