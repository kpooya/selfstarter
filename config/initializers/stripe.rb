require 'stripe'

if Rails.env.production?
  Stripe.api_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  STRIPE_PUBLISHABLE_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
else
  Stripe.api_key = "sk_test_nOsPS1Sgmw2yC1RfQvjoklWO"
  STRIPE_PUBLISHABLE_KEY = "pk_test_K9t4awU0QmOsGVt2OkFKA5dw"
end

# STRIPE_PLAN_ID = "some-awesome-plan"
# STRIPE_TRIAL_PERIOD = 1.month# For test

