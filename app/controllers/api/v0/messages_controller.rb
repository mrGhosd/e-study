class Api::V0::MessagesController < ApiController
  def create
    form = Form::Message.new(Message.new, params[:message])
    if form.submit
      render json: form.object.as_json
    else
      render json: form.object.errors.as_json
    end
  end
end