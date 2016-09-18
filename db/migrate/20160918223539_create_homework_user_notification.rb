class CreateHomeworkUserNotification < ActiveRecord::Migration
  def change
    create_table :homework_user_notifications do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :lesson, null: false, index: true
      t.integer :duration, null: false
      t.timestamps
    end
  end
end
