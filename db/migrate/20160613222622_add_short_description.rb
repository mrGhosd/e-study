# frozen_string_literal: true
class AddShortDescription < ActiveRecord::Migration
  def change
    add_column :courses, :short_description, :text
  end
end
