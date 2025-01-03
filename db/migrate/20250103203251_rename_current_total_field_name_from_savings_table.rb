class RenameCurrentTotalFieldNameFromSavingsTable < ActiveRecord::Migration[8.0]
  def change
    rename_column :savings_tables, :current_total, :current_value
  end
end
