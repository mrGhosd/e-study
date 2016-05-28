class CreateHomework < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.belongs_to :course, null: false
      t.belongs_to :user, null: false, index: true
      t.text :text, null: false
      t.timestamps
    end
  end
end
