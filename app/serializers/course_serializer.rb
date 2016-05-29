class CourseSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at

  has_many :homeworks
end
