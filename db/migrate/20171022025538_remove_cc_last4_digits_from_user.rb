class RemoveCcLast4DigitsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :cc_last4_digits
  end
end
