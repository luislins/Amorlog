class AddDefaultToTotalAndMaxValueInSavingsTables < ActiveRecord::Migration[8.0]
  def change
    change_column_default :savings_tables, :max_value_per_square, 0
    change_column_default :savings_tables, :max_value, 0
  end
end
