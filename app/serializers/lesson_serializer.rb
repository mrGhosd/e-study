# frozen_string_literal: true
class LessonSerializer < ActiveModel::Serializer
  root 'lesson'
  attributes :id, :title, :description, :slug, :created_at, :user_id, :course

  has_many :comments
  has_one :user, serializer: UserSerializer
  has_many :homeworks, serializer: HomeworkSerializer

  delegate :course, to: :object

  def homeworks
    scope.present? ? object.homeworks.where(user_id: scope.id) : []
  end
end
