class Address < ActiveRecord::Base
  attr_accessible :address, :address_additional, :city, :country, :name, :state, :user_id, :zip
end
