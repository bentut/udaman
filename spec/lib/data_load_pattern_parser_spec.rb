require 'spec_helper'

describe DataLoadPatternParser do
  before(:each) do
    @pattern_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_samples.xls"
    # @patterns_spreadsheet = DataLoadPatternParser.new(update_spreadsheet_name)
    # @patterns_spreadsheet.default_sheet = "PICT"
  end
  
  describe "DATE handling" do
    it "should load all dates into an array" do
      @patterns_spreadsheet = DataLoadPatternParser.new(@pattern_spreadsheet_name, "PICT")
      @patterns_spreadsheet.dates_array.count.should == 567
      @patterns_spreadsheet.dates_array[0].should == "1964-01-01"
      @patterns_spreadsheet.dates_array[-1].should == "2011-03-01"
    end
  
    it "should determine the frequency" do
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "PICT").date_frequency.should == "M"
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E").date_frequency.should == "Q"
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "UIC").date_frequency.should == "W"
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "CENSUS").date_frequency.should == "A"
    end
    
    it "should be able to determine a valid sequence of dates" do
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "PICT").dates_ok?.should == true
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E").dates_ok?.should == true
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "UIC").dates_ok?.should == true
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "CENSUS").dates_ok?.should == true
      
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "BD_M").dates_ok?.should == false
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "BD_Q").dates_ok?.should == false
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "BD_W").dates_ok?.should == false
      DataLoadPatternParser.new(@pattern_spreadsheet_name, "BD_A").dates_ok?.should == false
    end
  end
  
  describe "MODEL reading" do
    it "should load all paths into an array" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.paths_array.class.should == Array
      ps.paths_array.count == ps.dates_array.count
      ps.paths_array[0].should == %q|I:\data\rawdata\Const_QSER_E.XLS|
    end
    
    it "should load all worksheet names into an array" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.sheets_array.class.should == Array
      ps.sheets_array.count == ps.dates_array.count
      ps.sheets_array[0].should == "E-1"
    end
    
    it "should load all rows into an array" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.rows_array.class.should == Array
      ps.rows_array.count == ps.dates_array.count
      ps.rows_array[0].should == 37
    end
    
    it "should load all cols into an array" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.cols_array.class.should == Array
      ps.cols_array.count == ps.dates_array.count
      ps.cols_array[0].should == 7
    end
    
    it "should be able to return the mapping for a given date" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.map("2004-07-01")["path"].should == %q|I:\data\rawdata\Const_QSER_E.XLS|
      ps.map("2004-07-01")["sheet"].should == "E-1"
      ps.map("2004-07-01")["row"].should == 63
      ps.map("2004-07-01")["col"].should == 7
    end
  end
  
  describe "PATTERN recognition" do
    it "should recognize a static pattern" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.pattern(:cols).should == "7"
      ps.pattern(:paths).should == %q|I:\data\rawdata\Const_QSER_E.XLS|
      ps.pattern(:sheets).should == "E-1"
    end
    
    it "should identify a basic increment pattern" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "QSER_E")
      ps.pattern(:rows).should == "Pattern.increment(37, 1, 53)"
    end
    
    it "should identify a repeating numbers pattern" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "PICT")
      ps.pattern(:cols).should == "Pattern.repeating_numbers(1, 12, 567)"
    end
    
    it "should identify a repeating numbers x times pattern" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "PICT")
      ps.pattern(:rows).should == "Pattern.repeating_number_x_times(9, 1, 12, 567)"
    end
  end
  
  describe "DATE BASED STRING pattern making" do
    it "should be able to make a pattern with one date element" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "BLS_HIWI")
      paths_array = ps.paths_array
      match_array = Pattern.date_string(ps.dates_array[0], ps.date_frequency, %q|I:\data\rawdata\BLS_HIWI%Y.XLS|, ps.dates_array.count)
      paths_array.eql?(match_array).should be_true
    end
    
    it "should be able to make a pattern with two date elements" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "TOUR")
      paths_array = ps.paths_array
      match_array = Pattern.date_string(ps.dates_array[0], ps.date_frequency, %q|I:\data\rawdata\Tour_%b%y.XLS|, ps.dates_array.count)
      paths_array.each_index {|i| paths_array[i].downcase.should == match_array[i].downcase }
      #paths_array.eql?(match_array).should be_true
    end
    
    it "should be able to make a pattern with three date elements" do
      ps = DataLoadPatternParser.new(@pattern_spreadsheet_name, "TAX")
      paths_array = ps.paths_array
      match_array = Pattern.date_string(ps.dates_array[0], ps.date_frequency, %q|I:\data\rawdata\Tax_%b%y\%mcollec.XLS|, ps.dates_array.count)
      paths_array.each_index {|i| paths_array[i].downcase.should == match_array[i].downcase }
      #paths_array.eql?(match_array).should be_true
    end
  end
  
end