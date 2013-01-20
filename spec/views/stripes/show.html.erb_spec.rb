require 'spec_helper'

describe "stripes/show" do
  before(:each) do
    @stripe = assign(:stripe, stub_model(Stripe,
      :email => "Email",
      :customer_token => "Customer Token"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/Customer Token/)
  end
end
