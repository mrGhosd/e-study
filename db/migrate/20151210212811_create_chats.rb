# frozen_string_literal: true
class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats, &:timestamps
  end
end
