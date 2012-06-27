require 'spec_helper'

describe "data_lists/index.html.erb" do
  before(:each) do
    assign(:data_lists, [
      stub_model(DataList,
        :name => "Name",
        :list => "MyText",
        :startyear => 1,
        :endyear => 1,
        :startdate => "Startdate",
        :enddate => "Enddate"
      ),
      stub_model(DataList,
        :name => "Name",
        :list => "MyText",
        :startyear => 1,
        :endyear => 1,
        :startdate => "Startdate",
        :enddate => "Enddate"
      )
    ])
  end

  it "renders a list of data_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Startdate".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Enddate".to_s, :count => 2
  end
end
