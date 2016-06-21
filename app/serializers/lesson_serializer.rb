# frozen_string_literal: true
class LessonSerializer < ActiveModel::Serializer
  root 'lesson'
  attributes :id, :title, :description, :slug, :created_at, :user_id, :course,
             :homeworks

  has_many :comments

  delegate :course, to: :object

  def homeworks
    scope.present? ? object.homeworks.where(user_id: scope.id) : []
  end
end
