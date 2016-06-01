class AddSlugColumnToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :slug, :string, index: true
    add_index :courses, :slug, unique: true
  end
end
