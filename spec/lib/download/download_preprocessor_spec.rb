require 'spec_helper'

describe DownloadPreprocessor do
  before(:each) do
    @dsd = mock "data_source_download"
    @dsd.stub(:download).and_return(nil)
    DataSourceDownload.stub!(:get).and_return(@dsd)
    @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.xls")
    @dsd.stub(:extract_path_flex).and_return(nil)
    @handle = "pattern@test.com"
  end
  
  it "should be able to find the row for a given header" do
    DownloadPreprocessor.find_xls_header_row_in_col(1, "indicator", @handle, "increment_col_m").should == 2
  end
  
  it "should be able to find the column for a given header" do
    DownloadPreprocessor.find_xls_header_col_in_row(1, "indicator", @handle, "increment_row_a").should == 2
  end
  
  it "should be able to return the start date for a given cell" do
    DownloadPreprocessor.get_xls_start_date(3,1,@handle,"increment_row_a").should == "2000-01-01"
  end
  
  it "should be able to find the row for a given header for a csv" do
    @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern_csv.csv")
    DownloadPreprocessor.find_csv_header_row_in_col(1, "Indicator", @handle).should == 2
  end
  
  it "should be able to return the start date for a given cell" do
    @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern_csv.csv")
    DownloadPreprocessor.get_csv_start_date(1, 3, @handle).should == "2000-01-01"
  end
  

end #DownloadPreprocessor