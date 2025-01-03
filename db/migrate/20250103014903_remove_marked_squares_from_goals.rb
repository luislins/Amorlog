class RemoveMarkedSquaresFromGoals < ActiveRecord::Migration[8.0]
  def change
    remove_column :goals, :marked_squares, :text
  end
end
