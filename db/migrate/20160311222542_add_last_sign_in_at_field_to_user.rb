# frozen_string_literal: true
class AddLastSignInAtFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_sign_in_at,
               :datetime, default: Time.zone.today, null: false, index: true
  end
end
