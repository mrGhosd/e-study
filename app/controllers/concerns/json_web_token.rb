module JsonWebToken

  def validate_token
    begin
      decoded_token = JWT.decode auth_token, nil, false
      current_user = User.find_by_jwt_token(auth_token) if current_user.blank?
    rescue JWT::DecodeError
      head :unauthorized
    rescue JWT::ExpiredSignature
      head :unauthorized
    end
  end

  def jwt_secret
    Rails.application.secrets.jwt_secret
  end

  def generate_token_for_user(user)
    JWT.encode(user.attributes, jwt_secret, 'HS256')
  end
end
