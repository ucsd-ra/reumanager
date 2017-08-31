Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}
require "stripe"
Stripe.api_key = "sk_test_zO6UjE4YsjNNGCCMZ3k0gM1y"