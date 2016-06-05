# frozen_string_literal: true
class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :homeworks
end
