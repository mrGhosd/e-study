class UsersController < ApplicationController
  before_action :load_user, only: [:update, :show]

  def index
    users = User.all
    render json: users
  end

  def show
    render json: @user
  end

  def update
    user = Form::User.new(@user, params[:user])
    if user.submit
      render json: user.object, status: :ok
    else
      render json: user.object.errors, status: :unprocessable_entity
    end
  end

  def generate_new_password_email
    user = User.find_by(email: params[:email])
    if user
      user.send_reset_password_instructions
      render json: {success: true}.as_json, status: :ok
    else
      render json: {success: false}.as_json, status: :unprocessable_entity
    end
  end

  def reset_password
    user = User.reset_password_by_token(params[:user])
    if user.errors.blank?
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private
  def load_user
    @user = User.find(params[:id])
  end
end