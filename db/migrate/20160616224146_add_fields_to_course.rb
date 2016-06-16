# frozen_string_literal: true
class AddFieldsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :begin_date, :date, index: true, default: Time.zone.now
    add_column :courses, :end_date, :date, index: true, default: Time.zone.now + 1.month
    add_column :courses, :difficult, :integer, index: true, default: 0
  end
end
