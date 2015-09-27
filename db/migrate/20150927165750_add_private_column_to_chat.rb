class AddPrivateColumnToChat < ActiveRecord::Migration
  def change
    add_column :chats, :private, :boolean, default: true
  end
end
