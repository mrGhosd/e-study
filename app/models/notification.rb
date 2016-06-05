# frozen_string_literal: true
class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notificationable, polymorphic: true

  scope :active, -> { where(active: true) }
end
