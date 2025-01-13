class DropSavingsTableSquares < ActiveRecord::Migration[8.0]
  def change
    drop_table :savings_table_squares do |t|
      t.integer :value
      t.boolean :checked
      t.integer :savings_table_id, null: false
      t.timestamps
    end
  end
end
