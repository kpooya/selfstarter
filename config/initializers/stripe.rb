if Rails.env.production?
  Stripe.api_key = ENV["STRIPE_API_KEY"]
  STRIPE_PUBLISHABLE_KEY = "pk_live_zQopWHOhNqlucOhpVt4HRblw"
else
  Stripe.api_key = "sk_test_nOsPS1Sgmw2yC1RfQvjoklWO"
  STRIPE_PUBLISHABLE_KEY = "pk_test_K9t4awU0QmOsGVt2OkFKA5dw"
end
