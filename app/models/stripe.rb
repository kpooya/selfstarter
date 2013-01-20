class Stripe < ActiveRecord::Base
  attr_accessible :customer_token, :email
end
