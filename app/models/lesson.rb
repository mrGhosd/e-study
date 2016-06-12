# frozen_string_literal: true
class Lesson < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  belongs_to :course
  has_many :homeworks
  has_many :comments, as: :commentable

  friendly_id :slug, use: :finders
end
