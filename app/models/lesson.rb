# frozen_string_literal: true
class Lesson < ActiveRecord::Base
  extend FriendlyId
  AVAILABLE_TIMES = [30, 45, 60, 75, 90, 105, 120].freeze

  belongs_to :user
  belongs_to :course
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  has_many :homeworks
  has_many :comments, as: :commentable
  has_one :image, as: :attachable, dependent: :destroy

  friendly_id :slug, use: :finders
end
