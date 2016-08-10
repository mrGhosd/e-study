# frozen_string_literal: true
class CreateCourseTeachers < ActiveRecord::Migration
  def change
    add_column :lessons, :teacher_id, :integer, index: true
    add_index :lessons, :teacher_id
  end
end
