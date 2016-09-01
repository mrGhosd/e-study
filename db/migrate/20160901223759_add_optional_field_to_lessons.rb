class AddOptionalFieldToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :repeated, :boolean, default: false, index: true
    add_column :lessons, :begin_date, :datetime
    add_column :lessons, :period, :integer, index: true
  end
end
