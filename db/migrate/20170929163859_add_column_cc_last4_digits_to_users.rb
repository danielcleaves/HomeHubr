class AddColumnCcLast4DigitsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cc_last4_digits, :integer
  end
end
