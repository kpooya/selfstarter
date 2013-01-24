class Order < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  attr_accessible :billing_address_id, :expiration, :phone, :plan_id, :price, :shipping_address_id, :stripe_customer_id, :tracking_number, :transaction_id, :user_id

  before_validation :generate_uuid!, :on => :create
  validates_presence_of :price, :user_id

  def generate_uuid!
    begin
      self.uuid = SecureRandom.hex(16)
    end while Order.find_by_uuid(self.uuid).present?
  end

  def self.current
    Order.where("stripe_customer_id != ? OR stripe_customer_id != ?", "", nil).count
  end

  def self.revenue
    Order.all.inject(0) { |amount, order| amount + order.plan.price}
  end

  def self.goal
    Settings.project_goal
  end

  def self.percent
    (Order.current.to_f / Order.goal.to_f) * 100.to_f
  end
end
