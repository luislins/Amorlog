class AddMaxValuePerSquareFieldToSavingsTable < ActiveRecord::Migration[8.0]
  def change
    add_column :savings_tables, :max_value_per_square, :integer
  end
end
