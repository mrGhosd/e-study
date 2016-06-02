class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :homeworks
  has_many :lessons

  has_many :comments, as: :attachable

  friendly_id :slug, use: :finders
end
