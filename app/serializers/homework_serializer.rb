# frozen_string_literal: true
class HomeworkSerializer < ActiveModel::Serializer
  root 'homework'
  attributes :id, :text, :created_at, :user_id, :lesson, :course

  has_many :comments
  has_one :user, serializer: UserSerializer

  delegate :lesson, to: :object
  delegate :course, to: :object
end
