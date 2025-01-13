class AddSquaresTextToSavingsTables < ActiveRecord::Migration[8.0]
  def change
    add_column :savings_tables, :squares, :text
  end
end
