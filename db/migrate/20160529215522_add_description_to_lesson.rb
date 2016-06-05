# frozen_string_literal: true
class AddDescriptionToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :description, :text, null: false
  end
end
