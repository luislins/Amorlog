class RenameTotalFieldNameFromSavingsTable < ActiveRecord::Migration[8.0]
  def change
    rename_column :savings_tables, :total, :current_total
  end
end
