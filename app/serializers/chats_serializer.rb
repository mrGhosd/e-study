class ChatsSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :users, :updated_at

  def users
    object.users.as_json(methods: :image)
  end
end
