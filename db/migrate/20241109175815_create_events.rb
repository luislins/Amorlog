class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :couple, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.date :date
      t.string :event_type

      t.timestamps
    end
  end
end
