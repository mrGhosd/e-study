module SessionConcern
  TOKEN_NAME = 'estudyauthtoken'.freeze

  attr_writer :auth_token

  def auth_token
    @auth_token = request.headers[TOKEN_NAME]
  end

  attr_writer :current_user

  def current_user
    @current_user ||= User.find_by_jwt_token(auth_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
  end
end
