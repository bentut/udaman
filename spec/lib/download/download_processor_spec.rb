require 'spec_helper'

#figure out what to do with error conditions in these tests
describe DownloadProcessor do
  before(:all) do
    @data_a = {"2000-01-01" => 1, "2001-01-01" => 2, "2002-01-01" => 3, "2003-01-01" => 4 }
    @data_q = {"2000-07-01" => 1, "2000-10-01" => 2, "2001-01-01" => 3, "2001-04-01" => 4 }
    @data_m = {"2000-11-01" => 1, "2000-12-01" => 2, "2001-01-01" => 3, "2001-02-01" => 4 }
  end
  
  before(:each) do
    @dsd = mock "data_source_download"
    @dsd.stub(:download).and_return(nil)
    DataSourceDownload.stub!(:get).and_return(@dsd)
  end
  
  describe "xls tests" do
    before(:each) do
      @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.xls")
    end
    it "should handle basic incrementing columns in xls files" do
      options = {
        :file_type => "xls",
        :start_date => "2000-01-01",
        :sheet => "increment_col_a",
        :row => 2,
        :col => "increment:3:1",
        :frequency => "A"
      }
      DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_a
    end
  
    it "should handle basic incrementing columns in xls files in different named sheets" do
      options = {
        :file_type => "xls",
        :start_date => "2000-07-01",
        :sheet => "increment_col_q",
        :row => 2,
        :col => "increment:3:1",
        :frequency => "Q"
      }
      DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_q
    end
  
    it "should handle basic incrementing columns in xls files in different numbered sheets" do
      options = {
        :file_type => "xls",
        :start_date => "2000-07-01",
        :sheet => "sheet_num:2",
        :row => 2,
        :col => "increment:3:1",
        :frequency => "Q"
      }
      DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_q
    end
  end
  
  describe "csv tests" do
    before(:each) do
      @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern_csv.csv")
    end
    
    it "should handle basic incrementing columns in csv" do
      options = {
        :file_type => "csv",
        :start_date => "2000-01-01",
        :row => 2,
        :col => "increment:3:1",
        :frequency => "A"
      }
      DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_a
    end
  end

  describe "comprehensive examples" do
    before(:each) do
      @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/data_mapping_samples.xls")
    end
    
    it "should be able to read a start date from a spreadsheet" do
      options = {
        :file_type => "xls",
        :start_row => 2,
        :start_col => 1, 
        :frequency => "M" , 
        :sheet => "ROLLING_START_DATE", 
        :row => "increment:2:1", 
        :col => 2
      }
      data = DownloadProcessor.new("pattern@test.com", options).get_data
      data.keys.sort[0].should == "2010-12-01" 
      data["2011-06-01"].should == 9708.05
    end
    
    it "should be able to index dates in reverse and identify a special start date when a row and column are specified" do
      options = {
        :file_type => "xls",
        :start_row => 2,
        :start_col => 1,
        :rev => true, 
        :frequency => "M" , 
        :sheet => "JP_STKNS", 
        :row => "increment:2:1", 
        :col => 2
      }
      data = DownloadProcessor.new("pattern@test.com", options).get_data
      data["2011-09-01"].should == 9017.01 
      data["2011-06-01"].should == 9708.05
      data["2010-12-01"].should == 9939.8 
    end
    
    it "should be able to index dates in reverse and read start date from row / col with week day frequency" do
      options = {
        :file_type => "xls",
        :start_row => 2,
        :start_col => 1,
        :rev => true, 
        :frequency => "WD" , 
        :sheet => "US_STKNS_DATA", 
        :row => "increment:2:1", 
        :col => 2
      }
      data = DownloadProcessor.new("pattern@test.com", options).get_data
      data["2011-08-30"].should == 1209.76 
      data["2011-07-29"].should == 1300.12
      #something is wrong with weekday at these later dates and need to verify eventually
      #data["2011-06-20"].should == 1271.5
    end
  end
  
end


# it "should update the last status when it arrives at a cell that is not a valid float" do
#   dlp = DataLoadPattern.new(
#     :start_date => "1998-01-01", 
#     :frequency => "Q" , 
#     :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_E.xls|, 
#     :worksheet => "E-1", 
#     :row => "increment:37:1", 
#     :col => 7
#   )
#   dlp.retrieve("2011-04-01").should == "END"
#   dlp.last_read_status.should == "BREAK IN VALID DATA"
# end
# 
# it "should update the last status when a worksheet does not exist" do
#   dlp = DataLoadPattern.new(
#     :start_date => "1998-01-01", 
#     :frequency => "Q" , 
#     :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_E.xls|, 
#     :worksheet => "E-1wefwef", 
#     :row => "increment:37:1", 
#     :col => 7
#   )
#   dlp.retrieve("1998-01-01").should == "END"
#   dlp.last_read_status.should == "WORKSHEET DOES NOT EXIST"
# end
# 
# it "should update the last status when a workbook does not exist" do
#   dlp = DataLoadPattern.new(
#     :start_date => "1998-01-01", 
#     :frequency => "Q" , 
#     :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_Ewfewew.xls|, 
#     :worksheet => "E-1", 
#     :row => "increment:37:1", 
#     :col => 7
#   )
#   dlp.retrieve("1998-01-01").should == "END"
#   dlp.last_read_status.should == "WORKBOOK DOES NOT EXIST"
#   
# end