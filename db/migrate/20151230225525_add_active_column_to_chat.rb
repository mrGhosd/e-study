# frozen_string_literal: true
class AddActiveColumnToChat < ActiveRecord::Migration
  def change
    add_column :user_chats, :active, :boolean, null: false, default: true
  end
end
