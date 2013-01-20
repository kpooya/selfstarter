require 'spec_helper'

describe "pledges/show" do
  before(:each) do
    @pledge = assign(:pledge, stub_model(Pledge,
      :email => "Email",
      :stripe_customer_token => "Stripe Customer Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Stripe Customer Token/)
  end
end
