class Api::V0::CommentsController < Api::ApiController
  before_action :validate_token
  before_action :define_object

  def create
    form = Form::Comment.new(@object, params[:comment])
    if form.submit
      render json: { comment: form.object }
    else
      render json: { errors: form.errors }, status: :uprocessable_entity
    end
  end

  private

  def define_object
    comment_params = params[:comment]
    if comment_params[:type].present? && comment_params[:id].present?
      @object = comment_params[:type].camelize
                                     .constantize
                                     .find(comment_params[:id])
                                     .comments.build(user_id: current_user.id)
    end
  end
end
