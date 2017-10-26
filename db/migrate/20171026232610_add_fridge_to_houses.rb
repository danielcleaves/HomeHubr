class AddFridgeToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :fridge, :boolean
  end
end
