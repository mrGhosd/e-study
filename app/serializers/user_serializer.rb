# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  include DateConcern
  attributes :id, :last_name, :first_name,
             :email, :middle_name, :date_of_birth, :description,
             :created_at, :last_sign_in_at, :date_of_birth_h

  has_one :image, serializer: AttachSerializer
end
