class RemoveStartDateFromBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :start_date, :datetime
  end
end
