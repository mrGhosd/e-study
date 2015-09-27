class UserSerializer < ActiveModel::Serializer
  attributes :id, :surname, :name, :email, :secondname, :date_of_birth, :description, :created_at

  has_one :image
end