class CurrentUserSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name, :email, :middle_name, :notifications, :last_sign_in_at

  has_one :image, serializer: AttachSerializer

  def notifications
    object.notifications.active || []
  end
end
