class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.timestamps
      t.references :user, foreign_key: true
      t.string :card_id, null: false
      t.string :brand, null: false
      t.string :fingerprint, null: false
      t.string :exp_month, null: false
      t.string :exp_year, null: false
      t.integer :last4_digits, null: false
    end
  end
end
