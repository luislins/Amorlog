class AddUserToCouples < ActiveRecord::Migration[7.0]
  def change
    add_reference :couples, :user, null: true, foreign_key: true
  end
end
