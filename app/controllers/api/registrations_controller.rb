class Api::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user])
    if form.submit
      render json: form.object
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end