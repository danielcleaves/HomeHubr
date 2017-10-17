class AddNeighborhoodToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :Neighboorhood, :string
  end
end
