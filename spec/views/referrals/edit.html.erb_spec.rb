require 'spec_helper'

describe "referrals/edit" do
  before(:each) do
    @referral = assign(:referral, stub_model(Referral,
      :referrer_id => "MyString",
      :referee_id => "MyString"
    ))
  end

  it "renders the edit referral form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => referrals_path(@referral), :method => "post" do
      assert_select "input#referral_referrer_id", :name => "referral[referrer_id]"
      assert_select "input#referral_referee_id", :name => "referral[referee_id]"
    end
  end
end
