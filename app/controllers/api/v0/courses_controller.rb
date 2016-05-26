class Api::V0::CoursesController < Api::ApiController
  before_action :validate_token

  def index
    courses = current_user.courses
    render json: courses
  end

  def create
    form = Form::Course.new(current_user.courses.build, params[:course])
    if form.submit
      render json: form.object
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end
end
