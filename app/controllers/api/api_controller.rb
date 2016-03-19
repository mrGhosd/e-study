class Api::ApiController < ApplicationController
  include JsonWebToken
  include SessionConcern
  include ErrorsConcern
  respond_to :json

  before_action :update_last_sign_in_time, if: -> { current_user.present? }
  before_action :set_locale

  private

  def update_last_sign_in_time
    current_user.update!(last_sign_in_at: Time.zone.now)
  end

  def set_locale
    I18n.locale = locale_token || I18n.default_locale
  end
end
