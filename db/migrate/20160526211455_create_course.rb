class CreateCourse < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false, index: true
      t.text :description, null: false, index: true
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
