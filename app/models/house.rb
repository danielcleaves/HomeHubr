class House < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :bookings

  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: :true
  validates :bed_room, presence: :true
  validates :bath_room, presence: :true

  def full_address
    address + ',' + city + ',' + state + ',' + [zip_code].to_s
  end

  def cover_photo(size)
    if !photos.empty?
      photos[0].image.url(size)
    else
      'blank.jpg'
    end
  end

  def ready?
    price.present? && listing_name.present? && photos.present? && address.present?
  end

  def set_default_lead_price
    self.lead_price = 50
    save
  end
end
