# frozen_string_literal: true
class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :homeworks
  has_many :lessons
  has_one :image, as: :attachable, dependent: :destroy

  has_many :comments, as: :commentable

  friendly_id :slug, use: :finders

  enum difficult: { easy: 0, medium: 1, hard: 2 }
end
