class AddLengthFieldToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :length, :integer, index: true
  end
end
