# frozen_string_literal: true
class CourseTeacher < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'
end
