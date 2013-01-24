require 'spec_helper'

describe "referrals/show" do
  before(:each) do
    @referral = assign(:referral, stub_model(Referral,
      :referrer_id => "Referrer",
      :referee_id => "Referee"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Referrer/)
    rendered.should match(/Referee/)
  end
end
