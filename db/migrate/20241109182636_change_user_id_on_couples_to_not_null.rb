class ChangeUserIdOnCouplesToNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :couples, :user_id, false
  end
end
