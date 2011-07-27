require 'spec_helper'
require 'spec_data_hash.rb'

describe SeriesInterpolation do
  
  before(:all) do
    @dh = get_data_hash
    @data_files_path = "#{ENV["DATAFILES_PATH"]}/datafiles/"
  end
  
  describe "performing LINEAR INTERPOLATION" do
    it "should raise an error if the series is not semi annual" do
      ones = @dh.ns "ONES@TEST.Q"
      lambda {ones.interpolate :quarter, :linear}.should raise_error InterpolationException
    end
  
    it "should raise an error if the requested interpolation is not quarterly" do
      semi_to_interpolate = @dh.ns "PCEN@HON.S"
      lambda {semi_to_interpolate.interpolate :monthly, :linear}.should raise_error InterpolationException
    end
  
    it "should raise an error if the requested interpolation style is not linear" do
      semi_to_interpolate = @dh.ns "PCEN@HON.S"
      lambda {semi_to_interpolate.interpolate :quarter, :other}.should raise_error InterpolationException
    end
  
    it "should successfully interpolate quarterly values from semi-annual values (using Aremos style linear interpolation)" do
      semi_to_interpolate = @dh.ns "PCEN@HON.S"
      interpolated_results_spreadsheet = UpdateSpreadsheet.new @data_files_path+"/specs_output/quarter.xls"
      interpolated_data = interpolated_results_spreadsheet.series interpolated_results_spreadsheet.headers.keys[0]
      semi_to_interpolate.interpolate_to(:quarter, :linear, "INTERPOLATED@TEST.Q")
      "INTERPOLATED@TEST.Q".ts.identical_to?(interpolated_data).should be_true
    end
  end

end