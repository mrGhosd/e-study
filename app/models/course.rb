class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :homeworks
  has_many :lessons
  friendly_id :slug, use: :finders
end
