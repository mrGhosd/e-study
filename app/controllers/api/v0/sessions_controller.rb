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
    account_sid = 'ACe39c6a9666430e68107a6221b6a6aec0'
    auth_token = 'b58483b49e944e349dfd953149470141'
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.messages.create(from: '+15054314056', to: '+79214438239', body: 'Hey there!')
    render nothing: true
  end

  def destroy
    sign_out
    render nothing: true, status: :ok
  end
end
