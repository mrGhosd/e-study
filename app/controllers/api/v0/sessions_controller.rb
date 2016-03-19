class Api::V0::SessionsController < Api::ApiController
  before_action :validate_token, only: [:current, :destroy]

  def create
    form = Form::Session.new(nil, params[:session])
    if form.submit
      render json: { remember_token: form.token }
    else
      render json: { email: 'There is no such user' }, status: :unauthorized
    end
  end

  def current
    if current_user
      render json: current_user
    else
      render json: { user: nil }, status: :unauthorized
    end
  end

  def sms_code
    form = Form::PhoneAuth.new(nil, params[:auth])
    if form.submit
      render json: { success: true }
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    render nothing: true, status: :ok
  end
end
