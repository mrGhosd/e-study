# frozen_string_literal: true
class LessonsSerializer < ActiveModel::Serializer
  root 'lessons'
  attributes :id, :title, :description, :slug, :user_id, :course

  delegate :course, to: :object

  has_one :image, serializer: AttachSerializer
end
