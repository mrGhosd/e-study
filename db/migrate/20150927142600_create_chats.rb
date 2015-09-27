class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :owner_id, index: true, null: false
      t.string :name, index: true
      t.timestamps
    end
    add_foreign_key :chats, :users, column: :owner_id
  end
end
