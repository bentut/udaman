require 'spec_helper'

describe UpdateSpreadsheet do
  
  context "When Spreadsheet is has gibberish in columns and gibberish in rows and has only one sheet" do
    before(:each) do
      update_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/gibberish_one_sheet.xls"
      @update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
      @update_spreadsheet.default_sheet = @update_spreadsheet.sheets.first
    end
    
    it "should know its column headers are not series" do
      @update_spreadsheet.columns_have_series?.should == false
    end
    
    it "should know its row headers are not dates" do 
      @update_spreadsheet.rows_have_dates?.should == false
    end
    
    it "should know it is not formatted correctly" do
      @update_spreadsheet.update_formatted?.should == false
    end
    
  end
  context "When spreadsheet is valid and has one sheet and has headers in rows" do
    before(:each) do
      update_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/horizontal_update_spreadsheet.xls"
#      update_spreadsheet_name = "/Volumes/UHEROwork/data/bea/update/inc_upd.xls"
      @update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
      @update_spreadsheet.default_sheet = @update_spreadsheet.sheets.first
    end
    
    it "should verify the formatting of the spreadsheet is correct" do
      @update_spreadsheet.update_formatted?.should == true
    end
    
    
    it "should know if its row headers have series" do
      @update_spreadsheet.rows_have_series?.should == true      
    end
    
    
    it "should know if its column headers have dates" do
      @update_spreadsheet.columns_have_dates?.should == true
    end    

    it "should recognize names are in row headers" do
      @update_spreadsheet.header_location.should == "rows"
    end
    
    it "should return a hash of the row headers / series names with corresponding rows" do
      @update_spreadsheet.headers.keys.should include('YC@HI', 'YWAGE@HI','YOTLAB@HI', 'YOTLABPEN@HI','YCMIOG@HI')
    end
    
    it "should return a hash of dates and the corresponding cols" do
      @update_spreadsheet.dates.should include('2001-01-01'=>4)
      @update_spreadsheet.dates.should include('2002-01-01'=>5)
      @update_spreadsheet.dates.should include('2003-01-01'=>6)
      @update_spreadsheet.dates.should include('2004-01-01'=>7)
      @update_spreadsheet.dates.should include('2005-01-01'=>8)
      @update_spreadsheet.dates.keys.should include('2002-01-01', '2003-01-01','2004-01-01', '2005-01-01', '2006-01-01')
    end
    
    it "should return the number of days between consecutive dates in the spreadsheet" do
      @update_spreadsheet.date_interval.should >= 365
    end
    
    it "should return the frequency of dates in the spreadsheet" do
      @update_spreadsheet.date_frequency.should == :year
    end
    
    it "should return series data as a hash of dates mapped to values" do
      data_hash = @update_spreadsheet.series("YC@HI")
      data_hash.keys.should include('2001-01-01', '2002-01-01', '2003-01-01','2004-01-01')
      data_hash['2001-01-01'].should == 24658664
      data_hash['2002-01-01'].should == 26376058
    end
    # it should also do each of the functions below
  end
  context "When spreadsheet is valid and has one sheet and is organized by columns and monthly frequency" do
    before(:each) do
      update_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
      @update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
      @update_spreadsheet.default_sheet = @update_spreadsheet.sheets.first
    end
    
    it "should return the number of days between consecutive dates in the spreadsheet" do
      @update_spreadsheet.date_interval.should == 31
    end
    
    it "should return the frequency of dates in the spreadsheet" do
      @update_spreadsheet.date_frequency.should == :month
    end
  end
  context "When Spreadsheet is valid and has one sheet and is organized by columns" do
    before(:each) do
      #replace this with proper string path handling and not absolute path in case directory moves
      update_spreadsheet_name = "#{ENV["DATAFILES_PATH"]}/datafiles/formatted_one_sheet.xls"
      @update_spreadsheet = UpdateSpreadsheet.new_xls_or_csv(update_spreadsheet_name)
      @update_spreadsheet.default_sheet = @update_spreadsheet.sheets.first
    end
    it "should recognize names are in column headers" do
      @update_spreadsheet.header_location.should == "columns"
    end
    
    it "should return a hash of the column headers / series names with corresponding columns" do
      @update_spreadsheet.headers.keys.should include('GDP@JP.A','GDPDEF@JP.A','GDPPC@JP.A','GDPPC_R@JP.A')
    end
    
    it "should return a hash of dates and the corresponding rows" do
      @update_spreadsheet.dates.keys.should include('1975-01-01', '1976-01-01', '1977-01-01','1978-01-01', '1979-01-01', '1980-01-01', '1981-01-01', '1982-01-01','1983-01-01', '1984-01-01', '1985-01-01')
    end
    
    it "should return the number of days between consecutive dates in the spreadsheet" do
      @update_spreadsheet.date_interval.should >= 365
    end
    
    it "should return the frequency of dates in the spreadsheet" do
      @update_spreadsheet.date_frequency.should == :year
    end
    
    it "should return series data as a hash of dates mapped to values" do
      data_hash = @update_spreadsheet.series("GDP@JP.A")
      data_hash.keys.should include('1975-01-01', '1976-01-01', '1977-01-01','1978-01-01', '1979-01-01', '1980-01-01', '1981-01-01', '1982-01-01','1983-01-01', '1984-01-01', '1985-01-01')
      data_hash['1975-01-01'].should be_nil
      data_hash['1980-01-01'].should == 242838.7
    end
    
    it "should verify the formatting of the spreadsheet is correct" do
      @update_spreadsheet.update_formatted?.should == true
    end
    
    it "should know if its column headers have series names" do
      @update_spreadsheet.columns_have_series?.should == true
    end
    
    # it "should know if its column headers have dates" do
    # end
    
    it "should know if its row headers have dates" do
      @update_spreadsheet.rows_have_dates?.should == true
    end
    
    # it "should know if its row headers have series names" do
    # end
    
  end
end
