require 'spec_helper'

describe "orders/new" do
  before(:each) do
    assign(:order, stub_model(Order,
      :uuid => "MyString",
      :stripe_customer_id => "MyString",
      :transaction_id => "MyString",
      :billing_address_id => 1,
      :shipping_address_id => 1,
      :user_id => "MyString",
      :price => "9.99",
      :plan_id => 1,
      :tracking_number => 1,
      :phone => 1
    ).as_new_record)
  end

  it "renders new order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path, :method => "post" do
      assert_select "input#order_uuid", :name => "order[uuid]"
      assert_select "input#order_stripe_customer_id", :name => "order[stripe_customer_id]"
      assert_select "input#order_transaction_id", :name => "order[transaction_id]"
      assert_select "input#order_billing_address_id", :name => "order[billing_address_id]"
      assert_select "input#order_shipping_address_id", :name => "order[shipping_address_id]"
      assert_select "input#order_user_id", :name => "order[user_id]"
      assert_select "input#order_price", :name => "order[price]"
      assert_select "input#order_plan_id", :name => "order[plan_id]"
      assert_select "input#order_tracking_number", :name => "order[tracking_number]"
      assert_select "input#order_phone", :name => "order[phone]"
    end
  end
end
