require 'spec_helper'

describe "pledges/new" do
  before(:each) do
    assign(:pledge, stub_model(Pledge,
      :email => "MyString",
      :stripe_customer_token => "MyString"
    ).as_new_record)
  end

  it "renders new pledge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pledges_path, :method => "post" do
      assert_select "input#pledge_email", :name => "pledge[email]"
      assert_select "input#pledge_stripe_customer_token", :name => "pledge[stripe_customer_token]"
    end
  end
end
