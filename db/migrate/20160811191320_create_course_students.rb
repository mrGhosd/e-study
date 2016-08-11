# frozen_string_literal: true
class CreateCourseStudents < ActiveRecord::Migration
  def change
    create_table :course_students do |t|
      t.belongs_to :course, index: true
      t.integer :student_id, index: true
      t.timestamps
    end
  end
end
