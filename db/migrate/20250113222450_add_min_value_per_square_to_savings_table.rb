class AddMinValuePerSquareToSavingsTable < ActiveRecord::Migration[8.0]
  def change
    add_column :savings_tables, :min_value_per_square, :integer
  end
end
