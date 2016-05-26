class Api::V0::OauthController < Api::ApiController
  include OauthRequest

  before_action :load_user_info, only: :vk

  def vk
    form = Form::Oauth::Vk.new(User.new, @user_data)
    if form.submit
      render json: { token: form.token }
    else
      render json: { errors: form.errors }, stauts: :unprocessable_entity
    end
  end

  private

  def load_user_info
    @user_data = params[:code].present? ? vk_access_token(params[:code]) : params
    render json: @user_data['error'], status: :unprocessable_entity if @user_data['error'].present?
    @user_data = @user_data.merge('auth' => params[:auth]) if @user_data['auth'].blank?
  end
end
