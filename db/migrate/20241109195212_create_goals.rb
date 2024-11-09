class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.references :couple, null: false, foreign_key: true
      t.boolean :achieved

      t.timestamps
    end
  end
end
