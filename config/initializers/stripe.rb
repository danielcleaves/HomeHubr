Rails.configuration.stripe = {
	# :publishable_key => 'pk_live_8LVqi5FVXI49EkzQ0phyTjN4',
}

Stripe.api_key = ENV['STRIPE_SECRET_KEY']
# Rails.configuration.stripe[:secret_key]
