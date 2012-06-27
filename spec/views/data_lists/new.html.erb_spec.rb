require 'spec_helper'

describe "data_lists/new.html.erb" do
  before(:each) do
    assign(:data_list, stub_model(DataList,
      :name => "MyString",
      :list => "MyText",
      :startyear => 1,
      :endyear => 1,
      :startdate => "MyString",
      :enddate => "MyString"
    ).as_new_record)
  end

  it "renders new data_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => data_lists_path, :method => "post" do
      assert_select "input#data_list_name", :name => "data_list[name]"
      assert_select "textarea#data_list_list", :name => "data_list[list]"
      assert_select "input#data_list_startyear", :name => "data_list[startyear]"
      assert_select "input#data_list_endyear", :name => "data_list[endyear]"
      assert_select "input#data_list_startdate", :name => "data_list[startdate]"
      assert_select "input#data_list_enddate", :name => "data_list[enddate]"
    end
  end
end
