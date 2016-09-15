# frozen_string_literal: true
class CurrentUserSerializer < ActiveModel::Serializer
  root 'current_user'
  include DateConcern
  attributes :id, :last_name, :first_name, :email, :middle_name,
             :last_sign_in_at, :date_of_birth, :date_of_birth_h, :studying_courses

  has_one :image, serializer: AttachSerializer

  def studying_courses
    User.last.studying_courses.map(&:id)
  end
end
