require 'spec_helper'

describe "stripes/new" do
  before(:each) do
    assign(:stripe, stub_model(Stripe,
      :email => "MyString",
      :customer_token => "MyString"
    ).as_new_record)
  end

  it "renders new stripe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stripes_path, :method => "post" do
      assert_select "input#stripe_email", :name => "stripe[email]"
      assert_select "input#stripe_customer_token", :name => "stripe[customer_token]"
    end
  end
end
