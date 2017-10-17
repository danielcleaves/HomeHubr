class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @houses = @user.houses
  end

  def update_phone_number
    current_user.update_attributes(user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_registration_path, notice: 'Saved...'
  rescue Exception => e
    redirect_to edit_user_registration_path, alert: e.message.to_s
  end

  def verify_phone_number
    current_user.verify_pin(params[:user][:pin])

    if current_user.phone_verified
      flash[:notice] = 'Your phone number is verified.'
    else
      flash[:alert] = 'Cannot verify your phone number.'
    end

    redirect_to edit_user_registration_path
    rescue Exception => e
      redirect_to edit_user_registration_path, alert: e.message.to_s
    end

  def payment
  end

  def add_card
    if current_user.stripe_id.blank?
      customer = Stripe::Customer.create(
        email: current_user.email
      )

      # Add Credit Card to Stripe
      cc_info = customer.sources.create(source: params[:stripeToken])
      current_user.stripe_id = customer.id
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.source = params[:stripeToken]
      customer.save

      cc_info = customer.sources.data.first
    end

    current_user.build_credit_card(credit_card_details(cc_info))
    current_user.save!

    flash[:notice] = 'Your card is saved.'
    redirect_to payment_method_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to payment_method_path
  end

  def remove_card
    if current_user.valid_credit_card?(params[:last4_digits])
      begin
        customer = Stripe::Customer.retrieve(current_user.stripe_id)
        customer.sources.retrieve(current_user.credit_card.card_id).delete
        current_user.update!(credit_card: nil)
        flash[:notice] = 'Your card was removed successfully.'
      rescue Stripe::CardError => e
        flash[:alert] = e.message
      end
    else
      flash[:alert] = 'Credit card verification failed'
    end

    redirect_to payment_method_path
  end

  private

  def user_params
    params.require(:user).permit(:phone_number, :pin)
  end

  def credit_card_details(cc_card_obj)
    {
      card_id: cc_card_obj.id,
      brand: cc_card_obj.brand,
      fingerprint: cc_card_obj.fingerprint,
      exp_month: cc_card_obj.exp_month,
      exp_year: cc_card_obj.exp_year,
      last4_digits: cc_card_obj.last4
    }
  end
end
