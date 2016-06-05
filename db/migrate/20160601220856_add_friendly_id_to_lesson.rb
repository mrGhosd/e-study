# frozen_string_literal: true
class AddFriendlyIdToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :slug, :string, index: true
    add_index :lessons, :slug, unique: true
  end
end
