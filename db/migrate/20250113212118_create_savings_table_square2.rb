class CreateSavingsTableSquare2 < ActiveRecord::Migration[8.0]
  def change
    create_table :savings_table_squares do |t|
      t.integer :value
      t.boolean :checked
      t.belongs_to :savings_table, null: false, foreign_key: true

      t.timestamps
    end
  end
end
