class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :json
  # before_filter :authenticate_user!

  def main
    render 'layouts/application'
  end
end
