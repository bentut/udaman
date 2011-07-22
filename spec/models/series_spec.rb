require 'spec_helper'
require 'spec_data_hash.rb'

describe Series do
  before(:all) do
     @dh = get_data_hash
     @data_files_path = "/Users/Shared/Dev/uhero_db_mongomapper/spec/datafiles/"
   end
   
  describe "reporting OBSERVATION COUNTS" do
    before(:all) do
      @series_values = Series.create_dummy("monthly_test_series", :month, "2000-05-01", 1, 36)
      @series_some_nils = Series.create_dummy("monthly_test_series", :month, "2000-05-01", 1, 36)
      @original_count = @series_some_nils.data.count
      @series_some_nils.data['1800-01-01'] = nil
      @series_some_nils.data['1800-02-01'] = nil
      @series_some_nils.data['1800-03-01'] = nil
    end
    it "should have the report the number of observations as the length of the data when all data in the hash have values" do
      @series_values.observation_count.should == @series_values.data.count
    end

    it "should not report the same number of observations as the length of the data when some data in the hash are storing nils" do
      @series_some_nils.observation_count.should_not == @series_some_nils.data.count
    end

    it "should report the same number observations as there are non-nil values when some data in the hash are storing nils " do
      @series_some_nils.observation_count.should == @original_count
    end
  end
  
  
  
end
