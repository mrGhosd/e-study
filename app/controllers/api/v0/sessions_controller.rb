# frozen_string_literal: true
class Api::V0::SessionsController < Api::ApiController
  # before_action :validate_token, only: [:current, :destroy]

  def create
    form = Form::Session.new(nil, params[:session])
    if form.submit
      render json: { token: form.token }
    else
      render json: { errors: form.errors }, status: :unauthorized
    end
  end

  def current
    if current_user
      render json: current_user, serializer: CurrentUserSerializer
    else
      render json: { user: nil }, status: :unauthorized
    end
  end

  def destroy
    sign_out
    render nothing: true, status: :ok
  end
end
