require 'spec_helper'

describe DownloadProcessor do
  before(:all) do
    @data_a = {"2000-01-01" => 1, "2001-01-01" => 2, "2002-01-01" => 3, "2003-01-01" => 4 }
    @data_q = {"2000-07-01" => 1, "2000-10-01" => 2, "2001-01-01" => 3, "2001-04-01" => 4 }
    @data_m = {"2000-11-01" => 1, "2000-12-01" => 2, "2001-01-01" => 3, "2001-02-01" => 4 }
    @data_q_alt = {"2000-07-01" => 4, "2000-10-01" => 3, "2001-01-01" => 2, "2001-04-01" => 1 }
  end
  
  describe "behavior tests" do
    before(:each) do
      @dsd = mock "data_source_download"
      @dsd.stub(:download).and_return(nil)
      DataSourceDownload.stub!(:get).and_return(@dsd)
    end
  
    describe "xls tests" do
      before(:each) do
        @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.xls")
        @dsd.stub(:extract_path_flex).and_return(nil)
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
      
      it "should handle basic incrementing columns in xls files when first sheet is requested" do
        options = {
          :file_type => "xls",
          :start_date => "2000-07-01",
          :sheet => "sheet_num:1",
          :row => 2,
          :col => "increment:3:1",
          :frequency => "Q"
        }
        DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_q
      end
      
      #this style will not be used...
      it "should let you specify a specific download file to use in the case of a handle that downloads a zip" do
        options = {
          :file_type => "xls",
          :path => "#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/alternate.xls",
          :start_date => "2000-07-01",
          :sheet => "increment_col_a",
          :row => 2,
          :col => "increment:3:1",
          :frequency => "Q"
        }
        DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_q_alt
      end
      
      it "should use the handle's target if it's present, to use in the case that the handle downloads a zip" do
        @dsd.stub(:extract_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/alternate.xls")
        options = {
          :file_type => "xls",
          :start_date => "2000-07-01",
          :sheet => "increment_col_a",
          :row => 2,
          :col => "increment:3:1",
          :frequency => "Q"
        }
        DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_q_alt
      end
      
      
      #process here instead of in the integer processor object since has to read from file
      it "should let you specify a header instead of a row " do
        options = {
          :file_type => "xls",
          :start_date => "2000-01-01",
          :sheet => "increment_col_a",
          :row => "header",
          :col => "increment:3:1",
          :frequency => "A"
        }
        DownloadProcessor.new("pattern@test.com", options).get_data.should == @data_a
      end
      
      it "should let you specify a header instead of a column" do
        #or just create a new file
        @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/data_mapping_samples.xls")
        @dsd.stub(:extract_path_flex).and_return(nil)
        
         options = {
            :file_type => "xls",
            :start_row => 2,
            :start_col => 1,
            :rev => true, 
            :frequency => "M" , 
            :sheet => "JP_STKNS", 
            :row => "increment:2:1", 
            :col => "header"
          }
          data = DownloadProcessor.new("pattern@test.com", options).get_data
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
    
    describe "local files tests" do
      it "should cause an error if the handle is 'manual' but no file path is specified" do
        
      end
      
      it "should be able read the same kind of files, but specify a manual download and file path" do
        options = {
            :path => "#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern_csv.csv",
            :file_type => "csv",
            :start_date => "2000-01-01",
            :row => 2,
            :col => "increment:3:1",
            :frequency => "A"
        }
        DownloadProcessor.new("manual", options).get_data.should == @data_a
      end
    end #end local files test

    describe "comprehensive examples" do
      before(:each) do
        @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/data_mapping_samples.xls")
        @dsd.stub(:extract_path_flex).and_return(nil)
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
      
    end #end comprehensive examples
  end #end behavior scenarios
  
  describe "failure scenarios" do

    before(:all) do
      @options = {
        :file_type => "xls",
        :start_date => "2000-07-01",
        :sheet => "sheet_num:2",
        :row => 2,
        :col => "increment:3:1",
        :frequency => "Q"
      }
    end
    
    it "should raise an exception if file_type is not specified" do
      lambda { DownloadProcessor.new("HI@test.com", {}) }.should raise_error(RuntimeError, "File type must be specified when initializing a Download Processor")
    end
    
    it "should raise an exception if all of the necessary components are not present" do
      lambda { DownloadProcessor.new("HI@test.com", {:file_type => "xls"}) }.should raise_error(RuntimeError, "incomplete Download Processor specification because the following information is missing: start date information, row specification, column specification, sheet specification, frequency specification")
    end
    
    it "should raise an exception and tell you that a handle does not exist in the database" do
      lambda { DownloadProcessor.new("HI@test.com", @options).get_data }.should raise_error(RuntimeError, "handle 'HI@test.com' does not exist")
    end
    
    describe "error conditions past handle and validation" do
      before (:each) do
        @dsd = mock "data_source_download"
        @dsd.stub(:download).and_return({:status => 500})
        @dsd.stub(:url).and_return("http://broken_download.com")
        DataSourceDownload.stub!(:get).and_return(@dsd)
        @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.xls")
        @dsd.stub(:extract_path_flex).and_return(nil)
      end
      
      it "should raise an exception if download is not successful" do
        lambda { DownloadProcessor.new("HI@test.com", @options).get_data }.should raise_error(RuntimeError, "the download for handle 'HI@test.com failed with status code 500 when attempt to reach http://broken_download.com")
      end
    
      it "should raise an exception if file cannot be found" do
        @dsd.stub(:download).and_return({:status => 200})
        @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/no_file.xls")
      
        #problem because absolute path in there
        lambda { DownloadProcessor.new("HI@test.com", @options).get_data }.should raise_error(IOError, "file spec/no_file.xls does not exist")      
      end
    
      it "should raise an exception if sheet is not present" do
        @dsd.stub(:download).and_return({:status => 200})
        @options[:sheet] = "no sheet"
        lambda { DownloadProcessor.new("HI@test.com", @options).get_data }.should raise_error(RuntimeError, "sheet 'no sheet' does not exist in workbook 'spec/datafiles/specs/downloads/pattern.xls' [Handle: HI@test.com]")
      end
    end  
  end
  
end
