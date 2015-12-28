class RenameImagesTable < ActiveRecord::Migration
  def change
    rename_table :images, :files
    add_column :files, :type, :string
    rename_column :files, :imageable_id, :fileable_id
    rename_column :files, :imageable_type, :fileable_type
  end
end
