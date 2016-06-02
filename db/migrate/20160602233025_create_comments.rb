class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false
      t.text :text, null: false
      t.integer :commentable_id, null: false, index: true
      t.string :commentable_type, null: false, index: true
      t.timestamps
    end
  end
end
