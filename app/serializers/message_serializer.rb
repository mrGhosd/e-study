class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :chat_id, :created_at

  has_one :user
  has_one :chat
end
