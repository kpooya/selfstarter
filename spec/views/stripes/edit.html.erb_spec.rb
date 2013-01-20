require 'spec_helper'

describe "stripes/edit" do
  before(:each) do
    @stripe = assign(:stripe, stub_model(Stripe,
      :email => "MyString",
      :customer_token => "MyString"
    ))
  end

  it "renders the edit stripe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stripes_path(@stripe), :method => "post" do
      assert_select "input#stripe_email", :name => "stripe[email]"
      assert_select "input#stripe_customer_token", :name => "stripe[customer_token]"
    end
  end
end
