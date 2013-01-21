class User < ActiveRecord::Base
  attr_accessible :email, :phone, :plan, :country, :state, :zipcode, :city, :address, :stripe_customer_id
  has_many :orders
end
