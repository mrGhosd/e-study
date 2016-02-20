class Api::V0::RegistrationsController < Api::ApiController
  def create
    form = Form::Registration.new(User.new, params[:user])
    if form.submit
      token = generate_token_for_user(form.object)
      render json: { remember_token: token }
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end
