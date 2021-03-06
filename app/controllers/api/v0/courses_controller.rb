# frozen_string_literal: true
class Api::V0::CoursesController < Api::ApiController
  before_action :validate_token, only: [:create, :update, :destroy, :enroll]
  before_action :find_course, only: [:show, :update, :destroy, :enroll]
  before_action :can_update?, only: :update
  before_action :can_destroy?, only: :destroy

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
    render json: @course, serializer: CourseSerializer
  end

  def update
    form = Form::Course.new(@course, params[:course])
    if form.submit
      render json: form.object, serializer: CourseSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @course.destroy
      render json: @course, serializer: CourseSerializer
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def enroll
    form = Form::CourseEnroll.new(@course, current_user)
    if form.enroll!
      render json: form.course, serializer: CourseSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  private

  def find_course
    @course = Course.find(params[:id])
  end

  def can_update?
    authorize @course, :update? if current_user.present?
  end

  def can_destroy?
    authorize @course, :destroy? if current_user.present?
  end
end
