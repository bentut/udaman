require 'spec_helper'

describe DataLoadPattern do
  before(:all) do
    @pattern_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_samples.xls"
  end
  
  before(:each) do
    #@s = Series.create test changes ben noe
  end
  
  it "should compute the index of a given date for an annual pattern" do
    dlp = DataLoadPattern.new(
      :start_date => "2000-01-01", 
      :frequency => "A"  
    )
    dlp.compute_index_for_date("2005-01-01").should == 5
  end

  it "should compute the index of a given date for an semi-annual pattern" do
    dlp = DataLoadPattern.new(
      :start_date => "2000-01-01", 
      :frequency => "S"  
    )
    dlp.compute_index_for_date("2005-01-01").should == 10
  end
  
  it "should compute the index of a given date for an quarterly pattern" do
    dlp = DataLoadPattern.new(
      :start_date => "2000-01-01", 
      :frequency => "Q"  
    )
    dlp.compute_index_for_date("2005-01-01").should == 20
  end
  
  it "should compute the index of a given date for an monthly pattern" do
    dlp = DataLoadPattern.new(
      :start_date => "2000-01-01", 
      :frequency => "M"  
    )
    dlp.compute_index_for_date("2005-01-01").should == 60
  end
  
  it "should compute the index of a given date for an weekly pattern" do
    dlp = DataLoadPattern.new(
      :start_date => "2000-01-01", 
      :frequency => "W"  
    )
    dlp.compute_index_for_date("2000-01-15").should == 2
  end
  
  it "should compute the index of a given date for an daily pattern" do
    dlp = DataLoadPattern.new(
      :start_date => "2000-01-01", 
      :frequency => "D"  
    )
    dlp.compute_index_for_date("2000-01-16").should == 15
  end
  
  it "should compute the row for a row pattern correctly" do
    dlp = DataLoadPattern.new(
      :start_date => "1998-01-01", 
      :frequency => "Q" , 
      :row => "increment:37:1"
    )
    dlp.compute_row("1998-07-01").should == 39
      
  end
  
  it "should compute the mapping correctly for a given date" do
    dlp = DataLoadPattern.new(
      :start_date => "1998-01-01", 
      :frequency => "Q" , 
      :path => %q|I:\data\rawdata\Const_QSER_E.XLS|, 
      :worksheet => "E-1", 
      :row => "increment:37:1", 
      :col => 7
    )
    ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
    ps_result = ps.map("2004-07-01")
    dlp.compute("2004-07-01").each {|key, val| ps_result.should include(key => val)}
  end
  
  it "should compute mapping correctly for a date pattern example repeating number example" do
    dlp = DataLoadPattern.new(
      :start_date => "1990-01-01", 
      :frequency => "M" , 
      :path => %q|I:\data\rawdata\BLS_HIWI%Y.XLS|, 
      :worksheet => "State", 
      :row => 7, 
      :col => "repeat:2:13"
    )
    ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "BLS_HIWI")
    ps_result = ps.map("2004-07-01")
    dlp.compute("2004-07-01").each {|key, val| ps_result.should include(key => val)}    
  end
  
  it "should compute mapping correctly for a block and repeat pattern example" do
    dlp = DataLoadPattern.new(
      :start_date => "1964-01-01", 
      :frequency => "M" , 
      :path => %q|I:\data\rawdata\PICT.XLS|, 
      :worksheet => "fixed", 
      :row => "block:9:1:12", 
      :col => "repeat:1:12"
    )
    ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "PICT")
    ps_result = ps.map("2004-07-01")
    dlp.compute("2004-07-01").each {|key, val| ps_result.should include(key => val)}
    
  end
  
  it "should successfully retrieve a value for a given date" do
    dlp = DataLoadPattern.new(
      :start_date => "1998-01-01", 
      :frequency => "Q" , 
      :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_E.xls|, 
      :worksheet => "E-1", 
      :row => "increment:37:1", 
      :col => 7
    )
    dlp.retrieve("2004-10-01").should == 136.6
  end
  
  it "should update the last status when it arrives at a cell that is not a valid float" do
    dlp = DataLoadPattern.new(
      :start_date => "1998-01-01", 
      :frequency => "Q" , 
      :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_E.xls|, 
      :worksheet => "E-1", 
      :row => "increment:37:1", 
      :col => 7
    )
    dlp.retrieve("2011-04-01").should == "END"
    dlp.last_read_status.should == "BREAK IN VALID DATA"
  end
  
  it "should update the last status when a worksheet does not exist" do
    dlp = DataLoadPattern.new(
      :start_date => "1998-01-01", 
      :frequency => "Q" , 
      :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_E.xls|, 
      :worksheet => "E-1wefwef", 
      :row => "increment:37:1", 
      :col => 7
    )
    dlp.retrieve("1998-01-01").should == "END"
    dlp.last_read_status.should == "WORKSHEET DOES NOT EXIST"
  end
  
  it "should update the last status when a workbook does not exist" do
    dlp = DataLoadPattern.new(
      :start_date => "1998-01-01", 
      :frequency => "Q" , 
      :path => %Q|#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_Ewfewew.xls|, 
      :worksheet => "E-1", 
      :row => "increment:37:1", 
      :col => 7
    )
    dlp.retrieve("1998-01-01").should == "END"
    dlp.last_read_status.should == "WORKBOOK DOES NOT EXIST"
    
  end
  
  
  it "should be able to identify the start date and index as normal when a row and column are specified" do
    dlp = DataLoadPattern.new(
      :start_date => "row2:col1", 
      :frequency => "M" , 
      :path => @pattern_spreadsheet_name , 
      :worksheet => "csv", 
      :row => "increment:2:1", 
      :col => 2
    )
  end
  
  it "should be able to index dates in reverse when specified" do
  end
  
  it "should be able to index dates in reverse and identify a special start date when a row and column are specified" do
    dlp = DataLoadPattern.new(
      :start_date => "row2:col1:rev", 
      :frequency => "M" , 
      :path => @pattern_spreadsheet_name , 
      :worksheet => "JP_STKNS", 
      :row => "increment:2:1", 
      :col => 2
    )
    dlp.start_date_string.should == "2011-09-01"
    dlp.retrieve("2011-06-01").should == 9708.5
    
    
  end
  
  it "should be able to index dates in reverse and identify a special start date when a row and column are specified and frequency is daily and skips days" do
    dlp = DataLoadPattern.new(
      :start_date => "row2:col1:rev", 
      :frequency => "D" , 
      :path => @pattern_spreadsheet_name , 
      :worksheet => "US_STKNS_DATA", 
      :row => "increment:2:1", 
      :col => 2
    )
    dlp.start_date_string.should == "2011-09-01"
    dlp.retrieve("2011-06-01").should == 9708.5
    
    
  end
  
  
  
  
  # it "should load a single mapping from an xls file" do
  # end
  # 
  # it "should load multiple mappings from a single xls file" do
  # end
  # 
  # it "should know if there are no more dates left" do
  # end
  # 
  # it "should suggest a next date if there are no dates left" do
  # end
  # 
  # it "should identify patterns in rows" do
  # end
  # 
  # it "should identify patterns in cols" do
  # end
  # 
  # it "should identify patterns in worksheet" do
  # end
  # 
  # it "should identify patterns in spreadsheets" do
  # end
  
  
end