class CourseSerializer < ActiveModel::Serializer
  root 'course'
  attributes :id, :title, :description, :created_at

  has_many :lessons
end
