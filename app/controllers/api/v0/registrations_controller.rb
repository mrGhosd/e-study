class Api::V0::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user])
    if form.submit
      render json: { remember_token: form.token }
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end
