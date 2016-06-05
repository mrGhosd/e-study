# frozen_string_literal: true
class AddBelongsToLessonFieldToHomeworkModel < ActiveRecord::Migration
  def change
    remove_column :homeworks, :course_id, :integer
    add_column :homeworks, :lesson_id, :integer, index: true
  end
end
