class AddCurrentValueToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :current_value, :decimal, precision: 15, scale: 2, default: 0, null: false
  end
end
