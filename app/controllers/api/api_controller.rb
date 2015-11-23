class Api::ApiController < ApplicationController
  respond_to :json

  private

  def validate_token
    secret = 'secret'
    begin
      JWT.decode(auth_token, secret)
      current_user = User.find_by_jwt_token(auth_token) if current_user.blank?
    rescue
      head :unauthorized
    end
  end
end