class AddSquaresToSavingsTables < ActiveRecord::Migration[8.0]
  def change
    add_column :savings_tables, :squares, :json, default: []
  end
end
