class Referral < ActiveRecord::Base
  attr_accessible :referee_id, :referrer_id, :order_id
end
