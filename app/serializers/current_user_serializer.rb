# frozen_string_literal: true
class CurrentUserSerializer < ActiveModel::Serializer
  include DateConcern
  root 'current_user'
  attributes :id, :last_name, :first_name, :email, :middle_name, :notifications,
             :last_sign_in_at, :date_of_birth, :date_of_birth_h

  has_one :image, serializer: AttachSerializer
  has_one :background_image, serializer: AttachSerializer

  def notifications
    object.notifications.active || []
  end
end
