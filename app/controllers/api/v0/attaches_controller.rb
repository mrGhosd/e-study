class Api::V0::AttachesController < Api::ApiController
  def create
    form = Form::Attach.new(params[:type], params[:attach])
    if form.save
      render json: form.object.as_json, status: :ok
    else
      render json: form.errors.as_json, status: :unprocessable_entity
    end
  end
end
