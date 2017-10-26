class AddCarpetToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :carpet, :boolean
  end
end
