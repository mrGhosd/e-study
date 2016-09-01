# frozen_string_literal: true
class LessonsSerializer < ActiveModel::Serializer
  root 'lessons'
  attributes :id, :title, :description, :slug, :user_id, :course, :repeated
  attributes :period, :begin_date

  delegate :course, to: :object

  has_one :image, serializer: AttachSerializer
  has_one :teacher, serializer: UsersSerializer

  def repeated?
    object.is_repeated
  end
end
