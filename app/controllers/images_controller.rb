class ImagesController < ApplicationController
  def create
    image = Image.new(image_params)
    if image.save
      render json: image.as_json, status: :ok
    else
      render json: image.errors.as_json, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.permit(:file, :imageable_type, :imageable_id)
  end
end