# frozen_string_literal: true
class CourseSerializer < ActiveModel::Serializer
  root 'course'
  attributes :id, :title, :description, :slug, :created_at

  has_many :lessons
  has_many :comments
end
