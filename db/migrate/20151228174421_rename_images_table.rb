# frozen_string_literal: true
class RenameImagesTable < ActiveRecord::Migration
  def change
    rename_table :images, :attaches
    add_column :attaches, :type, :string
    rename_column :attaches, :imageable_id, :attachable_id
    rename_column :attaches, :imageable_type, :attachable_type
  end
end
