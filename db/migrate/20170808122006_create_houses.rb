class CreateHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :houses do |t|
      t.string :home_type
      t.integer :bed_room
      t.integer :bath_room
      t.integer :garage
      t.integer :sq_feet
      t.string :listing_name
      t.text :summary
      t.text :repairs
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.boolean :is_air
      t.boolean :is_heating
      t.boolean :is_occupied
      t.boolean :is_pool
      t.boolean :warranty
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
