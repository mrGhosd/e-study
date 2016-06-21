# frozen_string_literal: true
class Api::V0::HomeworksController < Api::ApiController
  before_action :validate_token, except: [:show]
  before_action :build_homework, only: :create
  before_action :find_homework, only: [:show, :update, :destroy]
  before_action :allow_to_update?, only: :update
  before_action :allow_to_destroy?, only: :destroy
  before_action :allow_to_show?, only: :show

  def create
    form = Form::Homework.new(@new_homework, params[:homework])
    if form.submit
      render json: { homework: form.object }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def show
    render json: @homework, serializer: HomeworkSerializer
  end

  def update
    form = Form::Homework.new(@homework, params[:homework])
    if form.submit
      render json: { homework: form.object }
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { deleted_homework: @homework } if @homework.destroy
  end

  private

  def allow_to_show?
    authorize @homework, :show? if current_user.present?
  end

  def allow_to_update?
    authorize @homework, :update? if current_user.present?
  end

  def allow_to_destroy?
    authorize @homework, :destroy? if current_user.present?
  end

  def build_homework
    @new_homework = Course.find(params[:course_id])
                          .lessons.find(params[:lesson_id])
                          .homeworks.build(user_id: current_user.id)
  end

  def find_homework
    @homework = Homework.find(params[:id])
  end
end
