# frozen_string_literal: true
class Api::V0::CoursesController < Api::ApiController
  before_action :validate_token, only: [:create, :update, :destroy]

  def index
    courses = Course.all
    render json: courses, each_serializer: CoursesSerializer
  end

  def create
    form = Form::Course.new(current_user.courses.build, params[:course])
    if form.submit
      render json: form.object, serializer: CourseSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def show
    course = Course.find(params[:id])
    render json: course, serializer: CourseSerializer
  end

  def update
    course = Course.find(params[:id])
    form = Form::Course.new(course, params[:course])
    if form.submit
      render json: form.object, serializer: CourseSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    course = current_user.courses.find(params[:id])
    if course.destroy
      render json: course, serializer: CourseSerializer
    else
      render json: course.errors, status: :unprocessable_entity
    end
  end
end
