# frozen_string_literal: true
class HomeworkSerializer < ActiveModel::Serializer
  root 'homework'
  attributes :id, :text, :created_at, :user_id, :lesson, :course

  has_one :user, serializer: UserSerializer

  delegate :lesson, to: :object

  def course
    object.lesson.course
  end
end
