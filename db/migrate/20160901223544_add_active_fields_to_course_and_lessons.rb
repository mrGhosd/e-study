class AddActiveFieldsToCourseAndLessons < ActiveRecord::Migration
  def change
    add_column :courses, :active, :boolean, default: true, index: true
    add_column :lessons, :active, :boolean, default: true, index: true
  end
end
