module SessionConcern
  TOKEN_NAME = 'estudyauthtoken'.freeze
  LOCALE_NAME = 'locale'.freeze

  attr_writer :auth_token

  def auth_token
    @auth_token = request.headers[TOKEN_NAME]
  end

  def locale_token
    request.headers[LOCALE_NAME]
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
