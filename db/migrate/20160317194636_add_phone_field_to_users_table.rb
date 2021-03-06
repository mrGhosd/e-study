# frozen_string_literal: true
class AddPhoneFieldToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_index :users, :phone, unique: true
  end
end
