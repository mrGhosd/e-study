# frozen_string_literal: true
class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :user, index: true
      t.string :provider, index: true
      t.string :uid, index: true
      t.timestamps
    end
  end
end
