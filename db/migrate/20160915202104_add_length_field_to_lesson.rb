class AddLengthFieldToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :end_date, :datetime, index: true
  end
end
