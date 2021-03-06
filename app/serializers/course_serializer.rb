# frozen_string_literal: true
class CourseSerializer < ActiveModel::Serializer
  root 'course'
  attributes :id, :title, :description, :short_description, :begin_date
  attributes :end_date, :difficult, :slug, :created_at, :active

  has_one :author, serializer: UserSerializer
  has_many :lessons, serializer: LessonsSerializer
  has_many :comments, serializer: CommentsSerializer
  has_one :image, serializer: AttachSerializer
  has_many :students, serializer: UsersSerializer

  def comments
    object.comments.limit(10)
  end

  def students
    object.students.limit(10)
  end
end
