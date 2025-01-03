class AddMarkedSquaresToGoals < ActiveRecord::Migration[8.0]
  def change
    add_column :goals, :marked_squares, :text
  end
end
