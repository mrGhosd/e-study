# frozen_string_literal: true
class LessonSerializer < ActiveModel::Serializer
  root 'lesson'
  attributes :id, :title, :description, :slug, :created_at, :course_id, :user_id

  has_many :comments
end
