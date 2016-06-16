# frozen_string_literal: true
class Api::V0::LessonsController < Api::ApiController
  before_action :validate_token, only: [:destroy]

  def show
    lesson = Course.find(params[:course_id]).lessons.find(params[:id])
    render json: lesson, serializer: LessonSerializer
  end

  def destroy
    lesson = Course.find(params[:course_id]).lessons.find(params[:id])
    render json: { deleted: lesson } if lesson.destroy
  end
end
