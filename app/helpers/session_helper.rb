module SessionHelper

  def auth_token=(token)
    @auth_token = token
  end

  def auth_token
    @auth_token = request.headers['estudyauthtoken']
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_jwt_token(auth_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
  end

  def create_token(user)
    secret = 'secret'
    self.current_user = user
    JWT.encode(user.attributes, secret)
  end
end