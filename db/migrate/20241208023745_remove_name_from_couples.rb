class RemoveNameFromCouples < ActiveRecord::Migration[7.0]
  def change
    remove_column :couples, :name
  end
end
