class CreditCard < ApplicationRecord
  belongs_to :user

  validates :card_id, presence: true
  validates :brand, presence: true
  validates :fingerprint, presence: true
  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :last4_digits, presence: true
end
