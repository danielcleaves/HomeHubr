Rails.configuration.stripe = {
	:publishable_key => 'pk_live_8LVqi5FVXI49EkzQ0phyTjN4',
	:secret_key => 'sk_live_zrtqeTx9jD2Y44sS9jUqbrsp'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]