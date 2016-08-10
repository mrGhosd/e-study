# frozen_string_literal: true
class CreateCourseTeachers < ActiveRecord::Migration
  def change
    create_table :course_teachers do |t|
      t.belongs_to :course, index: true, null: false
      t.integer :teacher_id, index: true, null: false
      t.timestamps
    end
  end
end
