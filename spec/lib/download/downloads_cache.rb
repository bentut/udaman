require 'spec_helper'

describe DownloadsCache do
  before(:each) do
    @dsd = mock "data_source_download"
    @dsd.stub(:download).and_return(nil)
    DataSourceDownload.stub!(:get).and_return(@dsd)
    @dc = DownloadsCache.new
  end
  
  describe "XLS Cache Requests" do
    before(:each) do
      @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.xls")
    end
  
    it "should return the correct Excel object from an xls call" do
      xls = @dc.xls("pattern@test.com", "increment_col_m")
      xls.class.should == Roo::Excel
      xls.cell(1,1).should == "increment_col_m"
    end
  
    it "should return a different Excel object when a different call is made" do
      xls = @dc.xls("pattern@test.com", "increment_col_m")
      xls.class.should == Roo::Excel
      xls.cell(1,1).should == "increment_col_m"
    
      xls = @dc.xls("pattern@test.com", "increment_col_a")
      xls.class.should == Roo::Excel
      xls.cell(1,1).should == "increment_col_a"
    end
  
    it "should try to download a file if a file is not present in the cache" do
      @dsd.should_receive(:download).exactly(1).times
      xls = @dc.xls("pattern@test.com", "increment_col_m")
    end

    it "should pull the file from the cache if the file is already present (and not download again)" do
      @dsd.should_receive(:download).exactly(1).times
      xls = @dc.xls("pattern@test.com", "increment_col_m")
      xls = @dc.xls("pattern@test.com", "increment_col_m")
    end

    it "should not download again if file is present, but sheet changes" do
      @dsd.should_receive(:download).exactly(1).times
      xls = @dc.xls("pattern@test.com", "increment_col_m")
      xls = @dc.xls("pattern@test.com", "increment_col_a")
    end
  end
  
  describe "CSV Cache Requests" do
    before(:each) do
      @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern_csv.csv")
    end
    
    it "should return the correct 2D array object from a csv call" do
      csv = @dc.csv("pattern@test.com")
      csv.class.should == Array
      csv[0].class.should == Array
      csv[0][0].should == "increment_col_a_csv"
    end
    
    it "should return the correct 2D array object from a csv call if called twice" do
      dummy_csv = @dc.csv("pattern@test.com")
      csv = @dc.csv("pattern@test.com")
      csv.class.should == Array
      csv[0].class.should == Array
      csv[0][0].should == "increment_col_a_csv"
    end
    
    it "should try to download the CSV if it is not already present in the cache" do
      @dsd.should_receive(:download).exactly(1).times
      csv = @dc.csv("pattern@test.com")
    end

    it "should pull the file from the cache if download has already happened " do
      @dsd.should_receive(:download).exactly(1).times
      csv = @dc.csv("pattern@test.com")
      csv = @dc.csv("pattern@test.com")
    end
  end
  
  describe "Text File Cache Requests" do
    before(:each) do
      @dsd.stub(:save_path_flex).and_return("#{ENV["DATAFILES_PATH"]}/datafiles/specs/downloads/pattern.txt")
    end
    
    it "should return the correct array of strings containing lines of file from a txt call" do
      txt = @dc.text("pattern@test.com")
      txt.class.should == Array
      txt[0].class.should == String
      txt[0].split(" ")[0].should == "series_id"
    end
    
    it "should return the correct array of strings containing lines of file from a txt call" do
      dummy_txt = @dc.text("pattern@test.com")
      txt = @dc.text("pattern@test.com")
      txt.class.should == Array
      txt[0].class.should == String
      txt[0].split(" ")[0].should == "series_id"  
    end
    
    it "should try to download the TXT file if it is not present in the cache" do
      @dsd.should_receive(:download).exactly(1).times
      csv = @dc.text("pattern@test.com")
    end
    
    it "should pull the file from the cache if the download has already happened" do
      @dsd.should_receive(:download).exactly(1).times
      csv = @dc.text("pattern@test.com")
      csv = @dc.text("pattern@test.com")
    end
    
  end
  
end