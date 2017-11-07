if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key: ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: 'pk_test_ARCABhRwvThEEXk7IaSfdlEm',
    secret_key: 'sk_test_6r362luE67jml0BLF3GhJ41X'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
