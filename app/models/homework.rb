# frozen_string_literal: true
class Homework < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  has_many :comments, as: :commentable
end
