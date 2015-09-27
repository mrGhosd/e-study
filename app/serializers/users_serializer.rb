class UsersSerializer < ActiveModel::Serializer
  attributes :id, :surname, :name, :email, :secondname, :created_at

  has_one :image
end