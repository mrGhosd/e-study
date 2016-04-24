class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.string :notificationable_type
      t.integer :notificationable_id, index: true
      t.boolean :active, index: true, defalut: true
      t.timestamps
    end
  end
end
