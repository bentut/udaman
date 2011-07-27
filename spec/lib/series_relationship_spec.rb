require 'spec_helper'

#this might be the slowest set of tests takes a full 60 seconds
#try several different create statements
#time results from creating
describe SeriesRelationship do
  describe "CLEANING DATA SOURCE operations" do
  
    before (:each) do
      Series.load_all_series_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls"
    end
  
    it "should remove the unused data source from a series with two data sources" do
      "VISJPDEMETRANS@HI.M".ts_append_eval %Q|"VISJPNS@HI.M".ts|
      "VISJPDEMETRANS@HI.M".ts.data_sources.count.should == 2
      "VISJPDEMETRANS@HI.M".ts.clean_data_sources
      "VISJPDEMETRANS@HI.M".ts.data_sources.count.should == 1
    end
  
    #could probably split this test up into two pieces
    it "should remove the unused data source from a series with three data sources" do

      "VISJPDEMETRA@HI.M".ts_append_eval %Q|"VISJPDEMETRANS@HI.M".ts|
      "VISJPDEMETRANS@HI.M".ts_append_eval %Q|"VISJPNS@HI.M".ts|

      "VISJPDEMETRA@HI.M".ts_append_eval %Q|"VISJPDEMETRA@HI.M".ts.load_mean_corrected_sa_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls", "Sheet1"|
      "VISJPDEMETRA@HI.M".ts_append_eval %Q|"VISJPDEMETRA@HI.M".ts.apply_seasonal_adjustment :multiplicative|
      "VISJPDEMETRA@HI.M".ts.data_sources.count.should == 3
      "VISJPDEMETRA@HI.M".ts.clean_data_sources
      "VISJPDEMETRA@HI.M".ts.data_sources.count.should == 2 #should just be the seasonal adjustement and mean corrected SA
    end
  
    it "should leave a series with one used datasources alone" do
      "VISJP@HI.M".ts.data_sources.count.should == 1
      "VISJP@HI.M".ts.clean_data_sources
      "VISJP@HI.M".ts.data_sources.count.should == 1
    end
  end

  describe "reporting DEPENDENTS and DEPENDENCIES" do
    before (:each) do
      Series.load_all_series_from "#{ENV["DATAFILES_PATH"]}/datafiles/specs/ECT.xls"
    end
  
    it "should recognize a component series as a dependency" do
      "ECT_DEPENDENT@HI.M".ts_append_eval %Q|"ECT@HON.M".ts + 1|
      "ECT_DEPENDENT@HI.M".ts.new_dependencies.index("ECT@HON.M").should be_true
    end
  
    it "should recognize dependents when it is a component series for another" do
      "ECT_DEPENDENT@HI.M".ts_append_eval %Q|"ECT@HON.M".ts + 1|
      "ECT@HON.M".ts.new_dependents.index("ECT_DEPENDENT@HI.M").should be_true
    end
  
    it "should recognize component series of multiple sources in the dependencies array" do
      "ECT_DEPENDENT@HI.M".ts_append_eval %Q|"ECT@HON.M".ts + 1|
      "ECT_DEPENDENT@HI.M".ts_append_eval %Q|"ECT_CALC@HON.M".ts + 1|
      "ECT_DEPENDENT@HI.M".ts.new_dependencies.index("ECT@HON.M").should be_true
      "ECT_DEPENDENT@HI.M".ts.new_dependencies.index("ECT_CALC@HON.M").should be_true
    end
  
    it "should recognize multiple dependents when it is a component for multiple series" do
      "ECT_DEPENDENT@HI.M".ts_append_eval %Q|"ECT@HON.M".ts + 1|
      "ECT_DEPENDENT2@HI.M".ts_append_eval %Q|"ECT@HON.M".ts + 1|
      "ECT@HON.M".ts.new_dependents.index("ECT_DEPENDENT@HI.M").should be_true
      "ECT@HON.M".ts.new_dependents.index("ECT_DEPENDENT2@HI.M").should be_true
      "ECT@HON.M".ts.new_dependents.index("ECT_DEPENDENT3@HI.M").should be_false
    end
  
  
  end
end