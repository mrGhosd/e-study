# frozen_string_literal: true
class AddDataToUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :password_digest, index: true, null: false
      t.datetime :date_of_birth, index: true
      t.text :description
      t.string :remember_token
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
