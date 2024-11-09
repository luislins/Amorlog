class AddPartnersToCouples < ActiveRecord::Migration[7.0]
  def change
    add_column :couples, :partner_1, :string
    add_column :couples, :partner_2, :string
  end
end
