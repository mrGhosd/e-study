# frozen_string_literal: true
class AddPhoneCodeFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone_code, :string, index: true
  end
end
