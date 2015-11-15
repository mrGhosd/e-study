class Api::SessionsController < Api::ApiController
  before_action :validate_token, only: [:current, :destroy]

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      render json: { remember_token: create_token(user) }
    else
      render json: {email: 'There is no such user'}, status: :unauthorized
    end
  end


  def current
    if current_user
      render json: current_user
    else
      render json: { user: nil }, status: :unauthorized
    end

  end

  def destroy
    sign_out
    render nothing: true, status: :ok
  end
end