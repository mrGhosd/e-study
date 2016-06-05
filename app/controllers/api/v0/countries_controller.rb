# frozen_string_literal: true
class Api::V0::CountriesController < Api::ApiController
  def index
    render json: Country.all
  end
end
