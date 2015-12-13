class ChatsSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  has_many :users
  has_many :messages

  def messages
    object.messages.last(20)
  end
end
