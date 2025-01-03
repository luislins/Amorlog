class RemoveMarkedValuesFromSavingTables < ActiveRecord::Migration[8.0]
  def change
    remove_column :savings_tables, :marked_values
  end
end
