class UsersSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name, :email, :middle_name, :created_at

  has_one :image
end