class AddNumericValueToGoal < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :numeric_value, :decimal, precision: 15, scale: 2
  end
end
