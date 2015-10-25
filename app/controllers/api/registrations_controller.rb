class Api::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user])
    if form.submit
      sign_in form.object
      render json: {user: form.object, remember_token: form.object.remember_token}
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end