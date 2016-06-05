# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name,
             :email, :middle_name, :date_of_birth, :description,
             :created_at, :last_sign_in_at

  has_one :image, serializer: AttachSerializer
  has_one :background_image, serializer: AttachSerializer
end
