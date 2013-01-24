require 'spec_helper'

describe "addresses/index" do
  before(:each) do
    assign(:addresses, [
      stub_model(Address,
        :name => "Name",
        :user_id => 1,
        :address => "Address",
        :address_additional => "Address Additional",
        :city => "City",
        :state => "State",
        :country => "Country",
        :zip => "Zip"
      ),
      stub_model(Address,
        :name => "Name",
        :user_id => 1,
        :address => "Address",
        :address_additional => "Address Additional",
        :city => "City",
        :state => "State",
        :country => "Country",
        :zip => "Zip"
      )
    ])
  end

  it "renders a list of addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Address Additional".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
  end
end
