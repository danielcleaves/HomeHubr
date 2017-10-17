class RemoveTotalFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :total, :integer
  end
end
