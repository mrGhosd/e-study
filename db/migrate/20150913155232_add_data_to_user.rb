class AddDataToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :surname, index: true
      t.string :name, index: true
      t.string :secondname, index: true
      t.date :date_of_birth
      t.text :description
    end
  end
end
