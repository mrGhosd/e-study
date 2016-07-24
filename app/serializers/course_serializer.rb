# frozen_string_literal: true
class CourseSerializer < ActiveModel::Serializer
  root 'course'
  attributes :id, :title, :description, :short_description, :begin_date,
             :end_date, :difficult, :slug, :created_at

  has_one :author, serializer: UserSerializer
  has_many :lessons, serializer: LessonsSerializer
  has_many :comments
  has_one :image, serializer: AttachSerializer
end
