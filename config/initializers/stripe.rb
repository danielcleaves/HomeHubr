Rails.configuration.stripe = {
	:publishable_key => 'pk_test_jvEuj3sEMfTMtMW8QRr2u4gq',
	:secret_key => 'sk_test_7ARXBMhgSdEYjXNiBquDzGcr'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]