# frozen_string_literal: true
class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :homeworks
  has_many :lessons
  has_one :image, as: :attachable, dependent: :destroy

  has_many :comments, as: :commentable

  has_many :course_teachers, foreign_key: 'teacher_id'
  has_many :teachers, through: :course_teachers

  friendly_id :slug, use: :finders

  enum difficult: { easy: 0, medium: 1, hard: 2 }
end
