class Api::ApiController < ApplicationController

  private

  def check_current_user
    request.headers['estudyauthtoken'].present?
  end
end