class Api::SessionsController < Api::ApiController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      render json: { user: user, remember_token: user.remember_token }
    else
      render json: {email: 'There is no such user'}, status: :unauthorized
    end
  end

  def current
    user = User.find_by(remember_token: auth_token)
    if user
      render json: user
    else
      render json: {user: nil}, status: :unauthorized
    end

  end

  def destroy
    sign_out
    render nothing: true, status: :ok
  end
end