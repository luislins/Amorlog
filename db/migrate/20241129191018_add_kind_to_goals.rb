class AddKindToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :kind, :integer, default: 0, null: false
  end
end
