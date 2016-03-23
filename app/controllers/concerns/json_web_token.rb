module JsonWebToken
  USER_NOT_FOUND = 'User not found'.freeze
  TOKEN_INVALID = 'Authorization token invalid'.freeze
  TOKEN_EXPIRED = 'Authorization token expired'.freeze

  def validate_token
    current_user = User.find_by_jwt_token(auth_token)
    raise ActiveRecord::RecordNotFound if current_user.blank?
  rescue ActiveRecord::RecordNotFound
    raise Api::Error.new(USER_NOT_FOUND, 404)
  rescue JWT::DecodeError
    raise Api::Error.new(TOKEN_INVALID, 401)
  rescue JWT::ExpiredSignature
    raise Api::Error.new(TOKEN_EXPIRED, 401)
  end

  def jwt_secret
    Rails.application.secrets.jwt_secret
  end

  def generate_token_for_auth(auth)
    JWT.encode(auth.id, jwt_secret, 'HS256')
  end

  def generate_token_for_user(user)
    JWT.encode(user.attributes, jwt_secret, 'HS256')
  end
end
