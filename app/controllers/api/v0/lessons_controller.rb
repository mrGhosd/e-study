# frozen_string_literal: true
class Api::V0::LessonsController < Api::ApiController
  before_action :find_lesson
  before_action :can_show?, only: :show
  before_action :allow_destroy?, only: :destroy
  before_action :validate_token, only: [:destroy]

  def show
    render json: @lesson, serializer: LessonSerializer
  end

  def destroy
    render json: { deleted: @lesson } if @lesson.destroy
  end

  private

  def allow_destroy?
    authorize @lesson if current_user
  end

  def can_show?
    authorize @lesson, :show? if current_user.present?
  end

  def find_lesson
    @lesson = Course.find(params[:course_id]).lessons.find(params[:id])
  end
end
