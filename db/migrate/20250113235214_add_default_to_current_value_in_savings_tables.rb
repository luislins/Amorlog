class AddDefaultToCurrentValueInSavingsTables < ActiveRecord::Migration[8.0]
  def change
    change_column_default :savings_tables, :current_value, 0
  end
end
