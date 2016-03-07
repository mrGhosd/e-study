module JsonWebToken
  def validate_token
    current_user = User.find_by_jwt_token(auth_token) if current_user.blank?
    raise ActiveRecord::RecordNotFound if current_user.blank?
  rescue ActiveRecord::RecordNotFound
    head :unauthorized
  rescue JWT::DecodeError
    head :unauthorized
  rescue JWT::ExpiredSignature
    head :unauthorized
  end

  def jwt_secret
    Rails.application.secrets.jwt_secret
  end

  def generate_token_for_user(user)
    JWT.encode(user.attributes, jwt_secret, 'HS256')
  end
end
