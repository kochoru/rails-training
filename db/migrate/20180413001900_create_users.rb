class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.references :department, foreign_key: true, null: false
      t.string :password, null: false
      t.string :email_address, null: false

      t.timestamps
    end
  end
end
