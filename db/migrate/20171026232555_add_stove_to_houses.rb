class AddStoveToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :stove, :boolean
  end
end
