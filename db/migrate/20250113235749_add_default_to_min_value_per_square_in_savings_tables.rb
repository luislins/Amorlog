class AddDefaultToMinValuePerSquareInSavingsTables < ActiveRecord::Migration[8.0]
  def change
    change_column_default :savings_tables, :min_value_per_square, 0
  end
end
