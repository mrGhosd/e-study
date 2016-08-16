# frozen_string_literal: true
class Api::V0::CommentsController < Api::ApiController
  before_action :validate_token, except: :index
  before_action :list_object, only: :index
  before_action :define_object, only: [:create, :update]
  before_action :new_object, only: :create
  before_action :edit_object, only: :update

  def index
    comments = @object.comments.page(params[:page] || 1).per(10)
    render json: comments
  end

  def create
    form = Form::Comment.new(@new_object, params[:comment])
    if form.submit
      render json: form.object, serializer: CommentSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def update
    form = Form::Comment.new(@edit_object, params[:comment])
    if form.submit
      render json: form.object, serializer: CommentSerializer
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    render json: { deleted: comment } if comment.destroy
  end

  private

  def define_object
    comment_params = params[:comment]
    if comment_params[:type].present? && comment_params[:id].present?
      @object = comment_params[:type].camelize
                                     .constantize
                                     .find(comment_params[:id])
    end
  end

  def list_object
    if params[:type].present? && params[:id].present?
      @object = params[:type].camelize
                             .constantize
                             .find(params[:id])
    end
  end

  def edit_object
    @edit_object = @object&.comments&.find(params[:id])
  end

  def new_object
    @new_object = @object&.comments&.build(user_id: current_user.id)
  end
end
