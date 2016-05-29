class Api::V0::CoursesController < Api::ApiController
  before_action :validate_token

  def index
    courses = current_user.courses
    render json: courses, each_serializer: CoursesSerializer
  end

  def create
    form = Form::Course.new(current_user.courses.build, params[:course])
    if form.submit
      render json: { course: form.object }, serializer: CourseSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def show
    course = current_user.courses.find(params[:id])
    render json: course, root: 'course', serializer: CourseSerializer
  end

  def update
    course = current_user.courses.find(params[:id])
    form = Form::Course.new(course, params[:course])
    if form.submit
      render json: { course: form.object }, serializer: CourseSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    course = current_user.courses.find(params[:id])
    if course.destroy
      render json: { deleted: course }, serializer: CourseSerializer
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end
end
