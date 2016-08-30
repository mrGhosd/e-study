class ChangeCourseBeginAndEndDateTypes < ActiveRecord::Migration
  def up
    change_table :courses do |t|
      t.change :begin_date, :datetime
      t.change :end_date, :datetime
    end
  end

  def down
    def up
      change_table :courses do |t|
        t.change :begin_date, :date
        t.change :end_date, :date
      end
    end
  end
end
