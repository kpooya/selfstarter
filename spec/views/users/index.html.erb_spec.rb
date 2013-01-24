require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :email => "Email",
        :name => "Name",
        :referring_code => "Referring Code"
      ),
      stub_model(User,
        :email => "Email",
        :name => "Name",
        :referring_code => "Referring Code"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Referring Code".to_s, :count => 2
  end
end
