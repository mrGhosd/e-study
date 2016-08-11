# frozen_string_literal: true
class Api::V0::SearchController < Api::ApiController
  before_action :validate_token, except: :search

  def search
    form = Form::Search.new(nil, params)
    render json: form.search, each_serializer: serializer_name
  end

  private

  def serializer_name
    "#{params[:object].pluralize.camelize}Serializer".constantize
  end
end
