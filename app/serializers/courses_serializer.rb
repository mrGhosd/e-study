# frozen_string_literal: true
class CoursesSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :short_description, :slug, :difficult, :created_at, :user_id, :active

  has_one :image, serializer: AttachSerializer
end
