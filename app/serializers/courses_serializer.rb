class CoursesSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :homeworks_size

  def homeworks_size
    object.homeworks.size
  end
end
