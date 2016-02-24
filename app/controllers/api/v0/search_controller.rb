class Api::V0::SearchController < Api::ApiController

  def search
    results = params[:object].camelize.constantize.search("*#{params[:query]}*").records.to_a
    render json: results
  end
end
