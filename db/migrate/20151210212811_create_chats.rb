class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats, &:timestamps
  end
end
