class AddHardwoodToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :hardwood, :boolean
  end
end
