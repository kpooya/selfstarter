class Pledge < ActiveRecord::Base
  attr_accessible :email, :stripe_customer_token
end
