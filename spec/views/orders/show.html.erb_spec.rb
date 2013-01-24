require 'spec_helper'

describe "orders/show" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :uuid => "Uuid",
      :stripe_customer_id => "Stripe Customer",
      :transaction_id => "Transaction",
      :billing_address_id => 1,
      :shipping_address_id => 2,
      :user_id => "User",
      :price => "9.99",
      :plan_id => 3,
      :tracking_number => 4,
      :phone => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Uuid/)
    rendered.should match(/Stripe Customer/)
    rendered.should match(/Transaction/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/User/)
    rendered.should match(/9.99/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
