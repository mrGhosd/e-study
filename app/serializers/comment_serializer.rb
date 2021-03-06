# frozen_string_literal: true
class CommentSerializer < ActiveModel::Serializer
  root 'comment'
  attributes :id, :user_id, :text, :commentable_id, :commentable_type
  has_one :user, serializer: UsersSerializer
end
