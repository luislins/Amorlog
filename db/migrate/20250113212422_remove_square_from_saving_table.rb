class RemoveSquareFromSavingTable < ActiveRecord::Migration[8.0]
  def change
    remove_column :savings_tables, :squares
  end
end
