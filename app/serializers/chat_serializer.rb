class ChatSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner_id, :created_at

  has_one :user, foreign_key: :owner_id
  has_many :messages
end