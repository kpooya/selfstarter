require 'spec_helper'

describe "plans/new" do
  before(:each) do
    assign(:plan, stub_model(Plan,
      :description => "MyString",
      :price => "9.99",
      :number => 1
    ).as_new_record)
  end

  it "renders new plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => plans_path, :method => "post" do
      assert_select "input#plan_description", :name => "plan[description]"
      assert_select "input#plan_price", :name => "plan[price]"
      assert_select "input#plan_number", :name => "plan[number]"
    end
  end
end
