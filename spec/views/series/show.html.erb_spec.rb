require 'spec_helper'

describe "series/show.html.erb" do
  before(:each) do
    @series = assign(:series, stub_model(Series,
      :name => "Name",
      :frequency => "Frequency",
      :description => "Description",
      :units => 1,
      :seasonally_adjusted => false,
      :last_demetra_datestring => "Last Demetra Datestring",
      :factors => {},
      :factor_application => "Factor Application",
      :prognoz_data_file_id => "Prognoz Data File",
      :aremos_missing => 1,
      :aremos_diff => 1.5,
      :mult => 1,
      :data => {}
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Frequency/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Last Demetra Datestring/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Factor Application/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Prognoz Data File/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
