require 'spec_helper'

describe "series/index.html.erb" do
  before(:each) do
    assign(:series, [
      stub_model(Series,
        :name => "Name",
        :frequency => "Frequency",
        :description => "Description",
        :units => 1,
        :seasonally_adjusted => false,
        :last_demetra_datestring => "Last Demetra Datestring",
        :factors => {},
        :factor_application => "Factor Application",
        :prognoz_data_file_id => "Prognoz Data File",
        :aremos_missing => 2,
        :aremos_diff => 1.5,
        :mult => 3,
        :data => {}
      ),
      stub_model(Series,
        :name => "Name",
        :frequency => "Frequency",
        :description => "Description",
        :units => 1,
        :seasonally_adjusted => false,
        :last_demetra_datestring => "Last Demetra Datestring",
        :factors => {},
        :factor_application => "Factor Application",
        :prognoz_data_file_id => "Prognoz Data File",
        :aremos_missing => 2,
        :aremos_diff => 1.5,
        :mult => 3,
        :data => {}
      )
    ])
  end

  it "renders a list of series" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Frequency".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Last Demetra Datestring".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2 #should actually be the factors hash
    assert_select "tr>td", :text => "Factor Application".to_s, :count => 2
    assert_select "tr>td", :text => "Prognoz Data File".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2 #should actually be the data hash
  end
end
