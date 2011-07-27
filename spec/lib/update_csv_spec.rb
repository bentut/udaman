require 'spec_helper'

describe UpdateCSV do
  
  
  context "When Spreadsheet is valid and has one sheet and is organized by columns" do
    before(:each) do
      #replace this with proper string path handling and not absolute path in case directory moves
      update_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/hbr_upd_m.csv"
      @update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
    end
    it "should recognize names are in column headers" do
      @update_spreadsheet.header_location.should == "columns"
    end
    
    it "should return a hash of the column headers / series names with corresponding columns" do
      @update_spreadsheet.headers_with_frequency_code.should include('KBSGFNS@HON.M','KBCONNS@HON.M')
    end
    
    it "should return a hash of dates and the corresponding rows" do
      @update_spreadsheet.dates.keys.should include('1987-01-01', '1987-12-01', '1987-02-01','1987-08-01', '1987-10-01', '2010-01-01', '2010-06-01', '2010-07-01','2010-02-01', '2010-05-01', '2010-09-01')
    end
    
    it "should return the number of days between consecutive dates in the spreadsheet" do
      @update_spreadsheet.date_interval.should >= 28
    end
    
    it "should return the frequency of dates in the spreadsheet" do
      @update_spreadsheet.date_frequency.should == :month
    end
    
    it "should return series data as a hash of dates mapped to values" do
      data_hash = @update_spreadsheet.series("KBSGFNS@HON.M")
      @update_spreadsheet.dates.keys.should include('1987-01-01', '1987-12-01', '1987-02-01','1987-08-01', '1987-10-01', '2010-01-01', '2010-06-01', '2010-07-01','2010-02-01', '2010-05-01', '2010-09-01')
      data_hash['1975-01-01'].should be_nil
      data_hash['2009-08-01'].should == 239
    end
    
    it "should verify the formatting of the spreadsheet is correct" do
      @update_spreadsheet.update_formatted?.should == true
    end
    
    it "should know if its column headers have series names" do
      @update_spreadsheet.columns_have_series?.should == true
    end
        
    it "should know if its row headers have dates" do
      @update_spreadsheet.rows_have_dates?.should == true
    end    
  end
  
  context "When spreadsheet is valid and has one sheet and has dates in the second column instead of the first" do
    before(:each) do
       update_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/ge_upd.csv"
       @update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
     end
     
    it "should return the number of days between consecutive dates in the spreadsheet" do
       @update_spreadsheet.date_interval.should >= 28
       @update_spreadsheet.date_interval.should <= 31
    end
     
    it "should return the frequency of dates in the spreadsheet" do
      @update_spreadsheet.date_frequency.should == :month
    end
    
    it "should contain dates even for the funky formatted revised months" do
      @update_spreadsheet.dates.keys.should include('2003-01-01', '2003-02-01', '2003-06-01', '2003-12-01',
                                                    '2004-01-01', '2004-02-01', '2004-06-01', '2004-12-01',
                                                    '2005-01-01', '2005-02-01', '2005-06-01', '2005-12-01',
                                                    '2010-01-01', '2010-02-01', '2010-06-01')
    end
    
    it "should have data for revised months and non revised months" do
      data_hash = @update_spreadsheet.series("TGBRTNS@HI")
      data_hash['2005-06-01'].should == 2007051.525
      data_hash['2004-04-01'].should == 1700499.7
    end
  end
  
  
end
