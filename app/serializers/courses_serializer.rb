class CoursesSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :slug, :created_at
end
