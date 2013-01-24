require 'spec_helper'

describe "addresses/show" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :name => "Name",
      :user_id => 1,
      :address => "Address",
      :address_additional => "Address Additional",
      :city => "City",
      :state => "State",
      :country => "Country",
      :zip => "Zip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/Address/)
    rendered.should match(/Address Additional/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Country/)
    rendered.should match(/Zip/)
  end
end
