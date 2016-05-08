class Api::V0::OauthController < Api::ApiController
  include OauthRequest

  def vk
    user_data = vk_access_token(params[:code])
    if user_data['error'].blank?
      form = Form::Oauth::Vk.new(User.new, user_data.merge('auth' => params[:auth]))
      if form.submit
        response_data = { token: form.token }
        status = :ok
      else
        response_data = { errors: form.errors }
        status = :unprocessable_entity
      end
    else
      response_data = { error: user_data['error'] }
      status = :unprocessable_entity
    end

    render json: response_data, status: status
  end
end
