class Api::V0::SearchController < Api::ApiController

  def search
    form = Form::Search.new(nil, params)
    render json: form.search
  end
end
