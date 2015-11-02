class Api::ApiController < ApplicationController


  private

  def validate_token
    secret = 'secret'
    begin
      JWT.decode(auth_token, secret)
      current_user = User.find_by_jwt_token(auth_token)
    rescue JWT::DecodeError
      head :unauthorized
    end
  end
end