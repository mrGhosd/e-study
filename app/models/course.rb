# frozen_string_literal: true
class Course < ActiveRecord::Base
  extend FriendlyId

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :homeworks
  has_many :lessons
  has_one :image, as: :attachable, dependent: :destroy

  has_many :comments, as: :commentable

  has_many :course_teachers, foreign_key: 'teacher_id'
  has_many :teachers, through: :course_teachers, source: :teacher

  has_many :course_students
  has_many :students, through: :course_students, class_name: 'User', source: :user

  friendly_id :slug, use: :finders

  enum difficult: { easy: 0, medium: 1, hard: 2 }

  def teachers
    lessons.map(&:teacher)
  end

  def self.test_timer
    CourseMailer.timer.deliver_now
  end
end
