class CreateSavingsTables < ActiveRecord::Migration[8.0]
  def change
    create_table :savings_tables do |t|
      t.integer :total, null: false
      t.integer :max_value, null: false
      t.json :marked_values, default: []

      t.timestamps
    end
  end
end