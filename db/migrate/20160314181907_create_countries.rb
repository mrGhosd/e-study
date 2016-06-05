# frozen_string_literal: true
class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name, null: false, index: true
      t.string :phone_code, null: false, index: true
    end
  end
end
