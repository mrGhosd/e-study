# frozen_string_literal: true
class CourseStudent < ActiveRecord::Base
  belongs_to :course
  belongs_to :user, class_name: 'User', foreign_key: 'student_id'
end
