require 'spec_helper'

describe "referrals/new" do
  before(:each) do
    assign(:referral, stub_model(Referral,
      :referrer_id => "MyString",
      :referee_id => "MyString"
    ).as_new_record)
  end

  it "renders new referral form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => referrals_path, :method => "post" do
      assert_select "input#referral_referrer_id", :name => "referral[referrer_id]"
      assert_select "input#referral_referee_id", :name => "referral[referee_id]"
    end
  end
end
