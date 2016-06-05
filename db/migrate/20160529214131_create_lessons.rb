# frozen_string_literal: true
class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title, null: false, index: true
      t.belongs_to :course, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
