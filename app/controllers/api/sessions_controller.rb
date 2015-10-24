class Api::SessionsController < Api::ApiController

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      render json: user
    else
      render json: user.errors
    end
  end

  def destroy

  end
end