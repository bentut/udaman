require 'spec_helper'

describe PrognozDataFile do
  describe "LOADING DATA from FILE" do
    before(:each) do
      @visns_path = "#{ENV["DATAFILES_PATH"]}/datafiles/tour_upd1.xls"
      
      @visns_output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_month1.xls"
      @visns_output_file = PrognozDataFile.new(:name => "test data file", :filename => @visns_output_path)
      
      @output_mismatch = UpdateSpreadsheet.new "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
      @output_spreadsheet = UpdateSpreadsheet.new @visns_output_path
    end
    
    it "should populate series loaded with frequency codes" do
      @visns_output_file.load
      @visns_output_file.series_loaded.keys[0].should == "VISNS@HI.M"
    end

    it "should populate frequency" do
      @visns_output_file.load
      @visns_output_file.frequency.should == :month
    end


    it "should return a success message if load was successful" do
      results = @visns_output_file.load
      results[:notice].should == "success"
    end
    
    it "should return an error message if load was unsuccessful" do
      visns_error_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_missing.xls"
      visns_error = PrognozDataFile.new(:name => "test data file", :filename => visns_error_path)
      results = visns_error.load
      results[:notice].should == "problem loading spreadsheet"
    end
    
    it "should identify the starting date" do
      @visns_output_file.load
      @visns_output_file.output_start_date.should == "1965-01-01"
    end

  end

  
  describe "RETRIEVING series data" do
    before(:each) do
      @visns_output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_month1.xls"
      @visns_output_file = PrognozDataFile.new(:name => "test data file", :filename => @visns_output_path)
      results = @visns_output_file.load
      
      @output_mismatch = UpdateSpreadsheet.new "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
      @output_spreadsheet = UpdateSpreadsheet.new @visns_output_path
    end
        
    it "should raise an exception if the series name is not formatted properly" do
      lambda{@visns_output_file.get_data_for("formatted_incorrectly", @output_spreadsheet)}.should raise_error SeriesNameException
    end
    
    it "should raise an exception if series is not present" do
      lambda{@visns_output_file.get_data_for("not@present.L", @output_spreadsheet)}.should raise_error PrognozDataFindException
    end
    
    it "should raise an exception if series is not present in update_spreadsheet" do
      lambda{@visns_output_file.get_data_for(@output_spreadsheet.headers.keys[0]+".M", @output_mismatch)}.should raise_error PrognozDataFindException
    end
    
    it "should return a data hash with datestrings as keys if series is present in PrognozDataFile object and in updatespreadsheet"do
      visns_data = @visns_output_file.get_data_for @output_spreadsheet.headers.keys[0]+".M", @output_spreadsheet
      visns_data.keys[1].length.should == 10
      visns_data.count.should > 1
    end
    
    it "should retrieve series data given the name of a series present and no update_spreadsheet object" do
      visns_data = @visns_output_file.get_data_for @output_spreadsheet.headers.keys[0]+".M"
      visns_data.keys[1].length.should == 10
      visns_data.count.should > 1
    end
  end
  
  
  describe "PREPARING to OUTPUT series data" do
    before(:each) do
      @visns_output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_month1.xls"
      @visns_output_file = PrognozDataFile.new(:name => "test data file", :filename => @visns_output_path)
    end
    
    it "should return the name of the month folder" do
      @visns_output_file.output_folder_name_for_date(Date.parse('2010-10-23')).should == "10M10"
    end
    
    it "should create a folder for current date if it doesn't already exist" do
      @visns_output_file.create_output_folder
    end
  end
  
  describe "OUTPUTTING series data" do
    before(:each) do      
      @visns_path = "#{ENV["DATAFILES_PATH"]}/datafiles/tour_upd1.xls"
      Series.load_all_series_from @visns_path
      
      @visns_output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_month1.xls"
      @visns_output_file = PrognozDataFile.new(:name => "test data file", :filename => @visns_output_path)
      @visns_output_file.load
    end
    
    it "should produce output dates from starting date to current date" do
      @visns_output_file.output_dates.should include("2001-01-01",@visns_output_file.output_start_date)
      @visns_output_file.output_dates.count.should > 550
    end
    
    it "should create a output file" do
      #can't use this because not capturing series
      #@visns_output_file.set_output_series("VISNS@HI.M",1000)      
      #@visns_output_file.output_series["VISNS@HI.M"] = 100
      #can actually test for and delete file
      @visns_output_file.write_xls
    end

  end
end
