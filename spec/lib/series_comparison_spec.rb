require 'spec_helper'
require 'spec_data_hash.rb'

describe SeriesComparison do

  before(:all) do
    @dh = get_data_hash
    @visns_output_path = "#{ENV["DATAFILES_PATH"]}/datafiles/prognoz_output_month1.xls"
    @visns_output_file = PrognozDataFile.new(:name => "test data file", :filename => @visns_output_path, :frequency => "month")
    results = @visns_output_file.load
    #@visns_output_file.save
  end
  
  before(:each) do
    @visns_output_file.save
    @visns = @dh.ns "VISNS@HI.M"
  end

   # test wuth multipliers   
    describe "MATCHING DATA with comparison hash" do    
      it "should declare dates match if dates in series data array match given array exactly" do
      	@visns.match_dates_with(@visns.data).should be_true
      end
    
      it "should declare dates do no match if given array has more dates, but otherwise contains all dates present in the series data array" do
        data_copy = @visns.data.clone
        data_copy["1881-01-01"] = 2001
        @visns.match_dates_with(data_copy).should be_false
      end
    
      it "should declare dates do not match if given array is missing any date present in the series data array" do
        data_copy = @visns.data.clone
        data_copy.delete "1981-01-01"
        @visns.match_dates_with(data_copy).should be_false
      end
    
      it "should declare that data values match for a given date and given array if values are exactly the same" do
        @visns.match_data_date("1981-01-01", @visns.data).should be_true
      end
    
      it "should declare that data values match for a given date and given array if values are within an acceptable tolerance range" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = @visns.at('1981-01-01') + (@visns.at('1981-01-01')*0.01)
        @visns.match_data_date("1981-01-01", data_copy).should be_true
      end
    
      it "should declare that data values match for a given date and given array if both values are nil" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = nil
        @visns.data["1981-01-01"] = nil
        @visns.match_data_date("1981-01-01", data_copy).should be_true      
      end
    
      it "should declare that data values do not match for a given date and given array if values are not within an acceptable tolerance range" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = @visns.at('1981-01-01') + (@visns.at('1981-01-01')*0.07)
        @visns.match_data_date("1981-01-01", data_copy).should be_false
      end
    
      it "should declare that data values do not match for a given date and a given array if values are completely different" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = 999999.1
        @visns.match_data_date("1981-01-01", data_copy).should be_false
      end
    
      it "should declare that data values do not match for a given date and a given array if values are different classes" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = "hello"
        @visns.data["1981-01-01"] = 3.0
        @visns.match_data_date("1981-01-01", data_copy).should be_false      
      end
    
      it "should declare that data values do not match for a given date and a given array if one value is nil and the other is not" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = nil
        @visns.data["1981-01-01"] = 2000
        @visns.match_data_date("1981-01-01", data_copy).should be_false
      
        data_copy["1981-01-01"] = 2000
        @visns.data["1981-01-01"] = nil
        @visns.match_data_date("1981-01-01", data_copy).should be_false
      end
    
    
      it "should declare a data array match given a data array if the array is exactly the same" do
        @visns.identical_to?(@visns.data).should be_true
      end
    
      it "should declare a data array match if data array values match and have the same number of non-nil elements" do
        data_copy = @visns.data.clone
        data_copy["1881-01-01"] = nil
        @visns.data["1881-02-01"] = nil
        @visns.data["1881-03-01"] = nil
        @visns.data["1881-01-01"] = nil
        @visns.identical_to?(data_copy).should be_true
      end
    
      it "should declare a data array mismatch if the given array has more non-nil elements than the series data array" do
        data_copy = @visns.data.clone
        data_copy["1881-01-01"] = 1999
        @visns.identical_to?(data_copy).should be_false
      end
    
      it "should declare a data array mismatch if the series data array has more non-nil elements than the series data array" do
        data_copy = @visns.data.clone
        @visns.data["1881-01-01"] = 1999
        @visns.identical_to?(data_copy).should be_false
      end
    
      it "should declare a data array mismatch if the series data array has different values than the given data array" do
        data_copy = @visns.data.clone
        data_copy["1981-01-01"] = 999999.1
        @visns.identical_to?(data_copy).should be_false
      end
    
    end

    # trying to remove this functionality.
    # describe "COMPARING DATA to PROGNOZ output file" do
    #       
    #   it "should find filename and return data match array if file is present" do
    #     @visns.save
    #     @visns_output_file.load
    #     
    #     results = @visns.name.ts.prognoz_data_results
    #     results[:prognoz_filename].should == @visns_output_file.filename
    #     results[:data_matches]['1981-01-01'][:database].should == 307.52
    #     results[:data_matches]['1981-01-01'][:prognoz].should == 307.52
    #     results[:data_matches]['1981-01-01'][:match].should be_true
    #   end
    # 
    #   it "should return a data match array with sources even if file is not present" do
    #     ns_series_name = "EIFNS@HI.M"
    #     ns_series_name.ts_eval= %Q|"#{ns_series_name}".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls"|
    #     ns_series = ns_series_name.ts
    #     ns_series.prognoz_data_results
    #     #puts ns_series.data_sources[0].description
    #     #ns_series.print
    #     results = ns_series.prognoz_data_results
    #     results[:prognoz_filename].should == "N/A"
    #     results[:data_matches]['1990-01-01'][:database].should == 9.5
    #     results[:data_matches]['1990-01-01'][:prognoz].should == "N/A"
    #     results[:data_matches]['1990-01-01'][:match].should be_true
    #   end
    # end  
  
  end
  