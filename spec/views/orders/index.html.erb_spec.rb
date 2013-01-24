require 'spec_helper'

describe "orders/index" do
  before(:each) do
    assign(:orders, [
      stub_model(Order,
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
      ),
      stub_model(Order,
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
      )
    ])
  end

  it "renders a list of orders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Uuid".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Customer".to_s, :count => 2
    assert_select "tr>td", :text => "Transaction".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
