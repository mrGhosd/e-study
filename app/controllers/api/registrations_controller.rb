class Api::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user])
    if form.submit
      token = JWT.encode(form.object, 'secret')
      render json: { remember_token: token }
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end