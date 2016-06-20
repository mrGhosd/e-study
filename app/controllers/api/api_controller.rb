# frozen_string_literal: true
class Api::ApiController < ApplicationController
  include JsonWebToken
  include SessionConcern
  include ErrorsConcern
  include Pundit
  respond_to :json

  before_action :set_locale

  rescue_from Api::Error do |e|
    error_response e, e.status, e.addition
  end

  rescue_from ::Pundit::NotAuthorizedError do |e|
    error = e.exception 'Not authorized for this action'
    error.set_backtrace e.backtrace
    error_response error, current_user.present? ? 403 : 401
  end

  private

  def error_response(exception, code, addition = false)
    obj = { error: exception.message }

    obj[:description] = addition if addition
    if Rails.env.development?
      obj[:exception] = exception.class.name
      obj[:backtrace] = exception.backtrace
    end
    render json: obj, status: code
  end

  def set_locale
    I18n.locale = locale_token || I18n.default_locale
  end
end
