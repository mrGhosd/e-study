class Api::V0::CoursesController < Api::ApiController
  before_action :validate_token

  def index
    courses = current_user.courses
    render json: courses
  end
end
