require 'spec_helper'

describe "pledges/index" do
  before(:each) do
    assign(:pledges, [
      stub_model(Pledge,
        :email => "Email",
        :stripe_customer_token => "Stripe Customer Token"
      ),
      stub_model(Pledge,
        :email => "Email",
        :stripe_customer_token => "Stripe Customer Token"
      )
    ])
  end

  it "renders a list of pledges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Customer Token".to_s, :count => 2
  end
end
