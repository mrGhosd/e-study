# frozen_string_literal: true
class CoursesSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :short_description, :slug, :created_at, :user_id
end
