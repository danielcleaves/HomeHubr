class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    house = House.find(params[:house_id])
    if current_user == house.user
      flash[:alert] = 'You are unable purchase your lead'
    elsif !current_user.has_payment_method?
      flash[:alert] = 'Please update your payment method'
      return redirect_to payment_method_path
    elsif !current_user.valid_credit_card?(params[:last4_digits])
      flash[:alert] = 'Credit card verification failed'
      return redirect_to house_path(house)
    else
      @booking = current_user.bookings.build
      @booking.house = house
      @booking.price = house.lead_price
      @booking.save

      flash[:notice] = 'Lead Successfully Purchased'
      charge(house, @booking)

    end
    redirect_to house
  end

  def your_leads
    @leads = current_user.bookings
  end

  def approve
    charge(@booking.room, @booking)
    redirect_to your_reservations_path
  end

  def decline
    @booking.Declined!
    redirect_to your_reservations_path
  end

  private

  def send_sms(house, booking)
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+17204106051',
      to: house.user.phone_number,
      body: "#{booking.user.fullname} is looking to communicate with you about your property."
    )
  end

  def charge(house, booking)
    unless booking.user.stripe_id.blank?
      customer = Stripe::Customer.retrieve(booking.user.stripe_id)
      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: booking.price * 100,
        description: house.listing_name,
        currency: 'usd'
      )

      if charge
        BookingMailer.send_email_to_buyer(booking.user, house).deliver_later if booking.user.setting.enable_email
        send_sms(house, booking) if house.user.setting.enable_sms
        flash[:notice] = 'Lead Purchased Successfully'
      else
        booking.Declined!
        flash[:alert] = 'Please change your payment method'
      end
    end
    rescue Stripe::CardError => e
      booking.declined!
      flash[:notice] = 'e.message'
    end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
    end
end
