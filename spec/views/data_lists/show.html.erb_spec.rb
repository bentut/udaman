require 'spec_helper'

describe "data_lists/show.html.erb" do
  before(:each) do
    @data_list = assign(:data_list, stub_model(DataList,
      :name => "Name",
      :list => "MyText",
      :startyear => 1,
      :endyear => 1,
      :startdate => "Startdate",
      :enddate => "Enddate"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Startdate/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Enddate/)
  end
end
