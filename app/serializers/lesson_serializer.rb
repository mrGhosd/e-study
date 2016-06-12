# frozen_string_literal: true
class LessonSerializer < ActiveModel::Serializer
  root 'lesson'
  attributes :id, :title, :description, :slug, :created_at, :user_id, :course

  has_many :comments
  has_many :homeworks

  delegate :course, to: :object
end
