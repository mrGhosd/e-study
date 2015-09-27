class CreateUserChats < ActiveRecord::Migration
  def change
    create_table :user_chats do |t|
      t.belongs_to :user, index: true
      t.belongs_to :chat, index: true
      t.timestamps
    end
  end
end
