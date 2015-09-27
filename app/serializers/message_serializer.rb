class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_id, :chat_id, :created_at

  has_one :user
end