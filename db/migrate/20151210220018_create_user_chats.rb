# frozen_string_literal: true
class CreateUserChats < ActiveRecord::Migration
  def change
    create_table :user_chats do |t|
      t.belongs_to :user
      t.belongs_to :chat
      t.timestamps
    end
  end
end
