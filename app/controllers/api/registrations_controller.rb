class Api::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user])
    if form.submit
      token = JWT.encode(user, 'secret')
      render json: {user: form.object, remember_token: token }
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end