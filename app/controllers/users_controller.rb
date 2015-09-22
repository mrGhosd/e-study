class UsersController < ApplicationController
  before_action :load_user, only: [:update, :show]
  def update
    if @user.update(user_params)
      render json: @user.as_json, status: :ok
    else
      render json: @user.errors.as_json, status: :unprocessable_entity
    end
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:surname, :name, :email, :secondname,
    :date_of_birth, image_attributes: [:id, :imageable_id, :imageable_type])
  end
end