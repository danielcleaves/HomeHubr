class AddLeadPriceToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :lead_price, :string
  end
end
