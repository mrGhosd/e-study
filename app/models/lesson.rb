# frozen_string_literal: true
class Lesson < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :course
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  has_many :homeworks
  has_many :comments, as: :commentable
  has_one :image, as: :attachable, dependent: :destroy
  has_many :homework_user_notifications

  friendly_id :slug, use: :finders
end
