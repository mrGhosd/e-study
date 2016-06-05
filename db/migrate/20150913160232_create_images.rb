# frozen_string_literal: true
class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :imageable_id, index: true
      t.string :imageable_type, index: true
      t.string :file
      t.timestamps
    end
  end
end
