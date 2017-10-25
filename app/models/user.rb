class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :fullname, presence: true, length: { maximum: 50 }

  has_many :houses
  has_many :bookings
  has_many :notifications
  has_one :credit_card, dependent: :destroy

  has_one :setting
  after_create :add_setting

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    return user if user

    where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
      u.email = auth.info.email
      u.password = Devise.friendly_token[0, 20]
      u.fullname = auth.info.name
      u.fb_image = auth.info.image
      u.uid = auth.uid
      u.provider = auth.provider

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      u.skip_confirmation!
    end
  end

  def generate_pin
    self.pin = SecureRandom.hex(2)
    self.phone_verified = false
    save
  end

  def add_setting
    Setting.create(user: self, enable_sms: true, enable_email: true)
  end

  def send_pin
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+17204106051',
      to: phone_number,
      body: "Your pin is #{pin}"
    )
  end

  def verify_pin(entered_pin)
    update(phone_verified: true) if pin == entered_pin
  end

  def has_payment_method?
    credit_card.present?
  end

  def valid_credit_card?(last4_digits)
    credit_card.try(:last4_digits).to_s == last4_digits
  end

  def can_view_lead_info?(house)
    bookings.exists?(house_id: house.id) || houses.exists?(id: house.id)
  end
end
