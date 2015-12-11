class ChatsSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :users

  def users
    object.users
  end
end
