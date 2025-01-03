class AddCoupleToSavingsTables < ActiveRecord::Migration[8.0]
  def change
    add_reference :savings_tables, :couple, null: false, foreign_key: true
  end
end
