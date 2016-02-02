class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :amount
      t.string :designer_uid
      t.string :customer_token
      t.integer :customer_id
      t.integer :designer_id

      t.timestamps null: false
    end
    add_index :charges, :customer_id
    add_index :charges, :designer_id
  end
end
