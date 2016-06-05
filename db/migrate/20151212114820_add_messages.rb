# frozen_string_literal: true
class AddMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :chat, index: true, null: false
      t.text :text
      t.timestamps
    end
  end
end
