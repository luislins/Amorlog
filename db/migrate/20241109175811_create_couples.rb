class CreateCouples < ActiveRecord::Migration[7.0]
  def change
    create_table :couples do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
