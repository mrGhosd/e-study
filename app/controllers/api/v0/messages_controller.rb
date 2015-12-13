class Api::V0::MessagesController < Api::ApiController
  before_action :validate_token
  before_action :prepare_new_message, only: :create

  def create
    form = Form::Message.new(@new_message, params[:message])
    if form.submit
      render json: form.object, serializer: MessageSerializer
    else
      render json: form.object.errors.as_json
    end
  end

  def prepare_new_message
    @new_message = current_user.messages.build(chat_id: params[:message][:chat_id])
  end
end
