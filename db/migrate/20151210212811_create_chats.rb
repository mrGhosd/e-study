class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
