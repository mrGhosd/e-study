class ChatsSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  has_many :users
  has_many :messages
end
