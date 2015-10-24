class AddDataToUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, index: true, null: false
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :password_digest, index: true, null: false
      t.string :remember_token
      t.timestamps
    end
  end
end
