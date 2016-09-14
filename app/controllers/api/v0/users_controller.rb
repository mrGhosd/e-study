# frozen_string_literal: true
class Api::V0::UsersController < Api::ApiController
  before_action :load_user, only: [:update, :show]
  before_action :validate_token, only: [:update]
  before_action :allow_to_update?, only: :update

  def index
    users = User.includes(:image).page(params[:page] || 1).per(10)
    Rack::MiniProfiler.step('fetch users') do
     users.all
    end
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
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def allow_to_update?
    authorize @user if current_user
  end

  def load_user
    @user = User.find(params[:id])
  end
end
