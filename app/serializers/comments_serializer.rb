# frozen_string_literal: true
class CommentsSerializer < ActiveModel::Serializer
  root 'comments'
  attributes :id, :user_id, :text, :commentable_id, :commentable_type
  has_one :user, serializer: UsersSerializer
end
