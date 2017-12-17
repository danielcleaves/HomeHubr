class AddStorageToHouses < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :storage, :boolean
  end
end
