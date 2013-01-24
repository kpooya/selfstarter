require 'spec_helper'

describe "addresses/new" do
  before(:each) do
    assign(:address, stub_model(Address,
      :name => "MyString",
      :user_id => 1,
      :address => "MyString",
      :address_additional => "MyString",
      :city => "MyString",
      :state => "MyString",
      :country => "MyString",
      :zip => "MyString"
    ).as_new_record)
  end

  it "renders new address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => addresses_path, :method => "post" do
      assert_select "input#address_name", :name => "address[name]"
      assert_select "input#address_user_id", :name => "address[user_id]"
      assert_select "input#address_address", :name => "address[address]"
      assert_select "input#address_address_additional", :name => "address[address_additional]"
      assert_select "input#address_city", :name => "address[city]"
      assert_select "input#address_state", :name => "address[state]"
      assert_select "input#address_country", :name => "address[country]"
      assert_select "input#address_zip", :name => "address[zip]"
    end
  end
end
