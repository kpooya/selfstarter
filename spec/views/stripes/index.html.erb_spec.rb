require 'spec_helper'

describe "stripes/index" do
  before(:each) do
    assign(:stripes, [
      stub_model(Stripe,
        :email => "Email",
        :customer_token => "Customer Token"
      ),
      stub_model(Stripe,
        :email => "Email",
        :customer_token => "Customer Token"
      )
    ])
  end

  it "renders a list of stripes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Customer Token".to_s, :count => 2
  end
end
