class UserSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name,
             :email, :middle_name, :date_of_birth, :description,
             :created_at

  has_one :image, serializer: AttachSerializer
end
