class AddDefaultToAchievedInGoals < ActiveRecord::Migration[7.0]
  def change
    change_column_default :goals, :achieved, from: nil, to: false
  end
end
