require 'spec_helper'

describe "series/new.html.erb" do
  before(:each) do
    assign(:series, stub_model(Series,
      :name => "MyString",
      :frequency => "MyString",
      :description => "MyString",
      :units => 1,
      :seasonally_adjusted => false,
      :last_demetra_datestring => "MyString",
      :factors => "",
      :factor_application => "MyString",
      :prognoz_data_file_id => "MyString",
      :aremos_missing => 1,
      :aremos_diff => 1.5,
      :mult => 1,
      :data => ""
    ).as_new_record)
  end

  it "renders new series form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => series_index_path, :method => "post" do
      assert_select "input#series_name", :name => "series[name]"
      assert_select "input#series_frequency", :name => "series[frequency]"
      assert_select "input#series_description", :name => "series[description]"
      assert_select "input#series_units", :name => "series[units]"
      assert_select "input#series_seasonally_adjusted", :name => "series[seasonally_adjusted]"
      assert_select "input#series_last_demetra_datestring", :name => "series[last_demetra_datestring]"
      assert_select "input#series_factors", :name => "series[factors]"
      assert_select "input#series_factor_application", :name => "series[factor_application]"
      assert_select "input#series_prognoz_data_file_id", :name => "series[prognoz_data_file_id]"
      assert_select "input#series_aremos_missing", :name => "series[aremos_missing]"
      assert_select "input#series_aremos_diff", :name => "series[aremos_diff]"
      assert_select "input#series_mult", :name => "series[mult]"
      assert_select "input#series_data", :name => "series[data]"
    end
  end
end
