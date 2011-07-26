require 'spec_helper'
require 'spec_data_hash.rb'

describe Series do
  before(:all) do
     @dh = get_data_hash
     @data_files_path = "#{ENV["DATAFILES_PATH"]}/datafiles/"
   end
   
  describe "reporting OBSERVATION COUNTS" do
    before(:all) do
      @series_values = Series.create_dummy("monthly_test_series", :month, "2000-05-01", 1, 36)
      @series_some_nils = Series.create_dummy("monthly_test_series", :month, "2000-05-01", 1, 36)
      @original_count = @series_some_nils.data.count
      @series_some_nils.data['1800-01-01'] = nil
      @series_some_nils.data['1800-02-01'] = nil
      @series_some_nils.data['1800-03-01'] = nil
    end
    it "should have the report the number of observations as the length of the data when all data in the hash have values" do
      @series_values.observation_count.should == @series_values.data.count
    end

    it "should not report the same number of observations as the length of the data when some data in the hash are storing nils" do
      @series_some_nils.observation_count.should_not == @series_some_nils.data.count
    end

    it "should report the same number observations as there are non-nil values when some data in the hash are storing nils " do
      @series_some_nils.observation_count.should == @original_count
    end
  end
  
  describe "DATA LOADING" do  
    before(:all) do
      @ns_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls"
      @ns_load_results = Series.load_all_series_from @ns_update_path
      @ns_series_names = @ns_load_results[:headers] 
      @ns_series_name = @ns_series_names.first
      @ns_series_loaded = @ns_series_name.ts
      
      @sa_update_path = "#{ENV["DATAFILES_PATH"]}/datafiles/sa_update.xls"
      @worksheet_name = "sadata"
      @sa_load_results = Series.load_all_sa_series_from @sa_update_path, @worksheet_name
      @sa_series_names = @sa_load_results[:headers] 
      @sa_series_name = @sa_series_names.first
      @sa_series = Series.get @sa_series_name
      @sa_series_loaded = Series.get @sa_series_name
    end
    
    describe "LOADING data from UPDATE SPREADSHEETS" do    
      before(:each) do
        @ns_series_loaded.save
        @ns_series = @ns_series_name.ts
      end
    
      it "should load a series with 247 values from the ns_update spreadsheet" do
        @ns_series.observation_count.should == 247
      end
    
      it "should store it's data with YYYY-MM-DD formatted datestrings" do
        @ns_series.data.each do |datestring,value|
          datestring.split("-").count.should == 3
          datestring.length.should == 10
        end
      end
    
      it "should return the names of other sheets besides the default or the one specified" do
        ns_update_path_transposed = "#{ENV["DATAFILES_PATH"]}/datafiles/horizontal_update_spreadsheet.xls"
        ns_transposed_load_results = Series.load_all_series_from ns_update_path_transposed
        ns_transposed_load_results[:sheets].should include("hi","hon","haw","kau","mau")
      end
    
      it "should store a single formatted source if the series does not exist in the database" do
        "ONES@TEST.Q".ts_append_eval %Q|"ONES@TEST.Q".tsn.load_from "#{@data_files_path+"specs/quarter.xls"}"|
        sources = "ONES@TEST.Q".ts.data_sources
        sources.count.should == 1
        sources[0].description.should == @data_files_path+"specs/quarter.xls"
        sources[0].eval.should == %Q|"ONES@TEST.Q".tsn.load_from "#{@data_files_path+"specs/quarter.xls"}"|
      end
    
      it "should add a new source for the series if the series exists" do
        @dh.cs "ONES@TEST.Q"
        Series.load_all_series_from(@data_files_path+"specs/quarter.xls")
        ones_cur = "ONES@TEST.Q".ts
        sources = ones_cur.data_sources
        sources.count.should == 2
        sources[1].description.should == @data_files_path+"specs/quarter.xls"
        sources[1].eval.should == %Q|"ONES@TEST.Q".tsn.load_from "#{@data_files_path+"specs/quarter.xls"}"|
      end
    
      it "should still have only one source if the series is loaded twice from the same data source." do
        Series.load_all_series_from(@data_files_path+"specs/quarter.xls")
        ones_cur = "ONES@TEST.Q".ts
        sources = ones_cur.data_sources
        sources.count.should == 1
      end
    end
  
    describe "LOADING data from DEMETRA OUTPUT" do    
      before (:each) do
        @ns_series_loaded.save
        @sa_series_loaded.save
        @ns_series = @ns_series_name.ts
        @sa_series = @sa_series_name.ts
      end
    
      it "should store it's data with YYYY-MM-DD formatted datestrings" do
        @sa_series.data.each do |datestring,value|
          datestring.split("-").count.should == 3
          datestring.length.should == 10
        end
      end
    
      it "should store the last date calculated by Demetra" do
        @sa_series.last_demetra_datestring.should == "2009-12-01"
      end
    
      it "should indicate it is a seasonally adjusted series" do
        @sa_series.seasonally_adjusted.should be_true
      end
    
      it "should be able to find its counterpart non seasonally adjusted series" do
        @ns_series.name.should == "EIFNS@HI.M"
      end
    
      it "should have a counterpart series in the database that can also return any  observations after the last demetra output date" do
        counterpart_ns_series = @sa_series.get_ns_series
        ns_values = counterpart_ns_series.get_values_after @sa_series.last_demetra_datestring
        ns_values.should include("2010-01-01"=>8.6)
        ns_values.should have(7).items
      end
    end
    
    describe "LOADING data from RAWDATA using PATTERNS" do
      before (:each) do
      end
      
      it "should pull the correct data using mapping from a pattern" do
        dlp = DataLoadPattern.new(
          :start_date => "1998-01-01", 
          :frequency => "Q" , 
          :path => "#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_test_files/Const_QSER_E.xls", 
          :worksheet => "E-1", 
          :row => "increment:37:1", 
          :col => 7
        )
        #KPGOVNS@HI.Q
        dlp.save
        pattern_id = dlp.id
        
        #need to optimize... should be comparable load time
        #move to Class level "Series" function
        t0 = Time.now
        s1 = Series.new.load_from_pattern_id pattern_id
        t1 = Time.now
        s2 = "KPGOVNS@HI.Q".tsn.load_from "#{ENV["DATAFILES_PATH"]}/datafiles/data_mapping_samples.xls", "q_series"
        t2 = Time.now
        #puts "Pattern Load: #{t1-t0} - Update Spreadsheet Load: #{t2-t1}"
        s1.identical_to?(s2.data).should be_true
      end
    end
    
    
    
  end
  
  
  describe "SEARCHING for existing series by name" do
    before(:each) do
      @series_values = Series.create_dummy("test_series@uhero", :month, "2000-05-01", 1, 2)
    end
    
    context "when frequency code is present in search name but not in database name" do
      before(:each) do
        @series_values = Series.create_dummy("test_series@uhero", :month, "2000-05-01", 1, 2)
      end
      
      # it "should find the series if code matches frequency attribute" do     
      #   result = Series.get "test_series@uhero.M"
      #   result.should_not be_nil
      # end
      
      it "should not find the series if code does not match frequency attribute" do
        result = Series.get "test_series@uhero.a"
        result.should be_nil
      end
    end

    context "when frequency code is not present in search name or in database name" do
      before(:each) do
        @series_values = Series.create_dummy("test_series@uhero", :month, "2000-05-01", 1, 2)
      end
 
      it "should not find a series if no series by that name exists" do
        lambda {Series.get "no_series_by@this_name"}.should raise_error SeriesNameException
      end

    end
    
    context "when frequency code is present in search name and in database name" do
      before(:each) do
        @series_values = Series.create_dummy("test_series@uhero.M", :month, "2000-05-01", 1, 2)
      end
      it "should find a series when the name is an exact match" do
        result = Series.get "test_series@uhero.M"
        result.should_not be_nil
      end
      
      it "should not find a series when the name has a different frequency code " do
        result = Series.get "test_series@uhero.A"
        result.should be_nil
      end
    end

  end
  
  
  describe "populating series with data from ONE OR MORE SOURCES" do
    it "should prioritize values over nil entries" do
      @dh.cs "ONES@TEST.Q"
      ones_hist       = @dh.ns "ONES_HIST@TEST.Q"
      ones_ones_hist  = @dh.ns "ONES_ONES_HIST@TEST.Q"
      Series.store "ONES@TEST.Q", ones_hist
      "ONES@TEST.Q".ts.identical_to?(ones_ones_hist.data).should be_true
    end

    it "should respect the order prioritize values in second array over self" do
      @dh.cs "ONES@TEST.Q"
      @dh.cs "TWOS_HIST@TEST.Q"
      
      ones_twos_hist = @dh.ns "ONES_TWOS_HIST@TEST.Q"
      twos_hist_ones = @dh.ns "TWOS_HIST_ONES@TEST.Q"
      
      Series.store "ONES@TEST.Q", @dh.ns("TWOS_HIST@TEST.Q")
      "ONES@TEST.Q".ts.identical_to?(ones_twos_hist.data).should be_true
      Series.store "TWOS_HIST@TEST.Q", @dh.ns("ONES@TEST.Q")
      "TWOS_HIST@TEST.Q".ts.identical_to?(twos_hist_ones.data).should be_true
    end
    
    it "should work with complex operations" do
      @dh.cs "ONES_ONES_HIST@TEST.Q"
      Series.store "ONES_ONES_HIST@TEST.Q", @dh.ns("ONES@TEST.Q")+@dh.ns("ONES_HIST@TEST.Q")
      Series.get("ONES_ONES_HIST@TEST.Q").identical_to?(@dh.ns("ONES_PLUS_ONES_HIST_MERGE_ONES_ONES_HIST@TEST.Q").data).should be_true
    end
    
    it "should successfully merge data when source(s) contain series with the same name" do
      Series.load_all_series_from(@data_files_path+"specs/quarter_load_merge.xls")
      Series.load_all_series_from(@data_files_path+"specs/quarter.xls")
      "LOAD_MERGE@TEST.Q".ts.identical_to?(@dh.ns("ONES_ONES_HIST@TEST.Q").data).should be_true
    end
    
    it "should store the ruby statement that creates it when set with eval syntax" do
      @dh.cs "ONES@TEST.Q"
      "SERIES@TEST.Q".ts_eval= %Q|"ONES@TEST.Q".ts + "ONES@TEST.Q".ts|
      sources = "SERIES@TEST.Q".ts.data_sources
      sources[0].eval.should == %Q|"ONES@TEST.Q".ts + "ONES@TEST.Q".ts|
    end
    
    it "should populate matching data in the source data list, and series data when set with eval syntax" do
      @dh.cs "ONES@TEST.Q"
      "SERIES@TEST.Q".ts_eval= %Q|"ONES@TEST.Q".ts + "ONES@TEST.Q".ts|
      sources = "SERIES@TEST.Q".ts.data_sources
      "SERIES@TEST.Q".ts.identical_to?(sources[0].data).should be_true
    end
    
    it "should set series data to product of running the statement when set with eval syntax" do
      @dh.cs "ONES@TEST.Q"
      ones =  "ONES@TEST.Q".ts
      "SERIES@TEST.Q".ts_eval= %Q|"ONES@TEST.Q".ts + "ONES@TEST.Q".ts|
      sources = "SERIES@TEST.Q".ts.data_sources
      (ones + ones).identical_to?("SERIES@TEST.Q".ts.data).should be_true
    end
    
    it "should generate correct source info for arithmetic" do
      ones =  @dh.ns "ONES@TEST.Q"
      "SERIES@TEST.Q".ts= ones + ones
      sources = "SERIES@TEST.Q".ts.data_sources
      sources.count.should == 1
      sources[0].description.should == "ONES@TEST.Q + ONES@TEST.Q"
    end
  
    it "should generate the correct source info for moving averages" do  
      "SERIES@TEST.Q".ts= @dh.ns("TO_AVG@TEST.M").moving_average
      sources = "SERIES@TEST.Q".ts.data_sources
      sources.count.should == 1
      sources[0].description.should == "Moving Average of TO_AVG@TEST.M"
    end
  
    it "should generate the correct source info for annual averages" do
      "SERIES@TEST.Q".ts= @dh.ns("TO_AVG@TEST.M").annual_average
      sources = "SERIES@TEST.Q".ts.data_sources
      sources.count.should == 1
      sources[0].description.should == "Annual Average of TO_AVG@TEST.M"
    end
    
    it "should generate the correct source info for interpolated series" do
      "SERIES@TEST.Q".ts= @dh.ns("PCEN@HON.S").interpolate(:quarter, :linear)
      sources = "SERIES@TEST.Q".ts.data_sources
      sources.count.should == 1
      sources[0].description.should == "Interpolated from PCEN@HON.S"
    end
  
    it "should store information about multiple sources" do
      ones =  @dh.ns "ONES@TEST.Q"
      twos_hist = @dh.ns "TWOS_HIST@TEST.Q"
      "SERIES@TEST.Q".ts= ones + ones
      sleep 1
      "SERIES@TEST.Q".ts_append twos_hist
      sources = "SERIES@TEST.Q".ts.data_sources_by_last_run
      sources.count.should == 2
      sources[0].description.should == "ONES@TEST.Q + ONES@TEST.Q"
      (ones + ones).identical_to?(sources[0].data).should be_true
      sources[1].description.should == "TWOS_HIST@TEST.Q"
      (twos_hist).identical_to?(sources[1].data).should be_true
    end
  
    it "should store information about information about multipler sources when using eval notation" do
      ones =  @dh.cs "ONES@TEST.Q"
      twos_hist = @dh.cs "TWOS_HIST@TEST.Q"
      "SERIES@TEST.Q".ts_eval= %Q|"ONES@TEST.Q".ts + "ONES@TEST.Q".ts|
      sleep 1
      "SERIES@TEST.Q".ts_append_eval %Q|"TWOS_HIST@TEST.Q".ts|
      sources = "SERIES@TEST.Q".ts.data_sources_by_last_run
      sources[0].eval.should == %Q|"ONES@TEST.Q".ts + "ONES@TEST.Q".ts|
      sources[1].eval.should == %Q|"TWOS_HIST@TEST.Q".ts|
    end
    
  end
  
  
  
  describe "DATA POINT dynamics" do    
    before(:all) do
      @data_hash = "EIFNS@HI.M".tsn.load_from("#{ENV["DATAFILES_PATH"]}/datafiles/ns_update.xls").data
      @data_no_nil = @data_hash.clone
      @data_no_nil.delete_if {|key,value| value.nil?}
    end
    
    it "should create datapoints for each element in a data hash" do
      Series.store("EIFNS@HI.M", Series.new(:data => @data_hash))
      "EIFNS@HI.M".ts.data_points.count.should == @data_no_nil.count  
    end
    
    #fill these out
    it "should pull all datapoints for a series and include non-current data points" do
      #Series.store("EIFNS@HI.M", Series.new(:data => @data_hash))
      "EIFNS@HI.M".ts_eval= %Q|"EIFNS@HI.M".ts + 10|
      sources = "EIFNS@HI.M".ts.data_sources
      sources[0].data_points.count.should == @data_no_nil.count
      sources[1].data_points.count.should == @data_no_nil.count
    end

    it "should get only current data points" do
      Series.store("EIFNS@HI.M", Series.new(:data => @data_hash))
      "EIFNS@HI.M".ts_eval= %Q|"EIFNS@HI.M".ts + 10|
      "EIFNS@HI.M".ts.current_data_points.count.should == @data_no_nil.count
    end
    
  end
  
  
end
