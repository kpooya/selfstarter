require 'spec_helper'

describe "referrals/index" do
  before(:each) do
    assign(:referrals, [
      stub_model(Referral,
        :referrer_id => "Referrer",
        :referee_id => "Referee"
      ),
      stub_model(Referral,
        :referrer_id => "Referrer",
        :referee_id => "Referee"
      )
    ])
  end

  it "renders a list of referrals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Referrer".to_s, :count => 2
    assert_select "tr>td", :text => "Referee".to_s, :count => 2
  end
end
