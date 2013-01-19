class User < ActiveRecord::Base
  attr_accessible :email, :phone, :plan, :country, :state, :zipcode, :city, :address
  has_many :orders
end
