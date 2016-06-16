# frozen_string_literal: true
class CourseSerializer < ActiveModel::Serializer
  root 'course'
  attributes :id, :title, :description, :short_description, :begin_date,
             :end_date, :difficult, :slug, :created_at

  has_many :lessons
  has_many :comments
end
