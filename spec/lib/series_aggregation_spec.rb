require 'spec_helper'
require 'spec_data_hash.rb'

describe SeriesAggregation do
  
  before(:all) do
    
    @dh = get_data_hash
    #DataPoint.ensure_index :series_id
    #DataPoint.ensure_index :date_string
    #DataPoint.ensure_index :current
    @expected_years         = [ "2001-01-01", "2002-01-01" ]
    @expected_month_to_year_sums     = { "2001-01-01"=>162, "2002-01-01"=>306 }
    @expected_month_to_year_avgs     = { "2001-01-01"=>13.5, "2002-01-01"=>25.5 }
    
    @expected_quarter_to_year_sums    = { "2001-01-01"=>18, "2002-01-01"=>34 }
    @expected_quarter_to_year_avgs    = { "2001-01-01"=>18/4.to_f, "2002-01-01"=>34/4.to_f }

    @expected_semi_to_year_sums       = { "2001-01-01"=>3, "2002-01-01"=>7, "2003-01-01"=>11, "2004-01-01"=>15, "2005-01-01"=>19 }
    @expected_semi_to_year_avgs       = { "2001-01-01"=>3/2.0, "2002-01-01"=>7/2.0, "2003-01-01"=>11/2.0, "2004-01-01"=>15/2.0, "2005-01-01"=>19/2.0 }
    
    @expected_semis                   = [ "2000-07-01",
                                          "2001-01-01", "2001-07-01", 
                                          "2002-01-01", "2002-07-01"]
                                          
    @expected_quarters                = [ "2000-07-01", "2000-10-01",
                                          "2001-01-01", "2001-04-01", "2001-07-01", "2001-10-01",
                                          "2002-01-01", "2002-04-01", "2002-07-01", "2002-10-01", 
                                          "2003-01-01" ]
    @expected_month_to_semi_sums      = { "2000-07-01"=>27, 
                                          "2001-01-01"=>63, "2001-07-01"=>99,
                                          "2002-01-01"=>135, "2002-07-01"=>171 }

    @expected_month_to_semi_avgs      = { "2000-07-01"=>27/6.0, 
                                          "2001-01-01"=>63/6.0, "2001-07-01"=>99/6.0,
                                          "2002-01-01"=>135/6.0, "2002-07-01"=>171/6.0 }
    
    @expected_month_to_quarter_sums  = { "2000-07-01"=>9, "2000-10-01"=>18, 
                                        "2001-01-01"=>27, "2001-04-01"=>36, "2001-07-01"=>45, "2001-10-01"=>54,
                                        "2002-01-01"=>63, "2002-04-01"=>72, "2002-07-01"=>81, "2002-10-01"=>90, 
                                        "2003-01-01"=>99 }
                                
    @expected_month_to_quarter_avgs  = { "2000-07-01"=>9/3.to_f, "2000-10-01"=>18/3.to_f, 
                                        "2001-01-01"=>27/3.to_f, "2001-04-01"=>36/3.to_f, "2001-07-01"=>45/3.to_f, "2001-10-01"=>54/3.to_f,
                                        "2002-01-01"=>63/3.to_f, "2002-04-01"=>72/3.to_f, "2002-07-01"=>81/3.to_f, "2002-10-01"=>90/3.to_f, 
                                        "2003-01-01"=>99/3.to_f }
                                        
    @monthly_series_to_aggregate = Series.create_dummy("monthly_test_series", :month, "2000-05-01", 1, 36)
    @quarterly_series_to_aggregate = Series.create_dummy("quarterly_test_series", :quarter, "2000-04-01", 1, 12)
    @semi_annual_series_to_aggregate = Series.create_dummy("semi_test_series", :semi, "2000-07-01", 1, 11)
    @annual_series_to_aggregate = Series.create_dummy("annual_test_series", :year, "2000-01-01", 1, 12)
     
    @data_files_path = "#{ENV["DATAFILES_PATH"]}/datafiles/"
  end
  
  describe "performing GROUPING" do
    it "should group monthly data into quarters and only keep complete quarters" do
      grouped_data = @monthly_series_to_aggregate.group_data_by :quarter
      @expected_quarters.each {|date| grouped_data.keys.should include(date)}
      grouped_data.should have(11).items
    end

    it "should group monthly data into years and only keep complete years" do
      grouped_data = @monthly_series_to_aggregate.group_data_by :year
      @expected_years.each {|date| grouped_data.keys.should include(date)}
      grouped_data.should have(2).items
    end
  
    it "should group quarterly data into years and only keep complete years" do
      grouped_data = @quarterly_series_to_aggregate.group_data_by :year
      @expected_years.each {|date| grouped_data.should include(date)}
      grouped_data.should have(2).items
    end

    it "should group semi annual data into years and only keep complete years" do
      grouped_data = @semi_annual_series_to_aggregate.group_data_by :year
      @expected_years.each {|date| grouped_data.should include(date)}
      grouped_data.should have(5).items
    end
    
    it "should group quarterly data to semis and only keep complete semis" do
      grouped_data = @quarterly_series_to_aggregate.group_data_by :semi
      @expected_semis.each {|date| grouped_data.should include(date)}
      grouped_data.should have(6).items
    end
    
    it "should group monthly data to semis and only keep complete semis" do
      grouped_data = @monthly_series_to_aggregate.group_data_by :semi
      @expected_semis.each {|date| grouped_data.should include(date)}
      grouped_data.should have(5).items
    end
    
    it "should raise an AggregationException for grouping attempts on Annual Data" do
      lambda {@annual_series_to_aggregate.group_data_by(:month)}.should raise_error AggregationException
    end
  end
  
  describe "performing AGGREGATION" do
    it "should aggregate monthly data into quarters using a sum operation" do
      aggregated_data = @monthly_series_to_aggregate.aggregate_data_by :quarter, :sum
      @expected_month_to_quarter_sums.each {|date, sum| aggregated_data.should include(date=>sum)}
      aggregated_data.should have(11).items
    end
  
    it "should aggregate monthly data into years using a sum operation" do
      aggregated_data = @monthly_series_to_aggregate.aggregate_data_by :year, :sum
      @expected_month_to_year_sums.each {|date, sum| aggregated_data.should include(date=>sum)}
      aggregated_data.should have(2).items
    end

    it "should aggregate monthly data into semi_annuals using a sum operation" do
      aggregated_data = @monthly_series_to_aggregate.aggregate_data_by :semi, :sum
      @expected_month_to_semi_sums.each {|date, sum| aggregated_data.should include(date=>sum)}
      aggregated_data.should have(5).items
    end
    
    it "should aggregate monthly data into quarters using an average operation" do
      aggregated_data = @monthly_series_to_aggregate.aggregate_data_by :quarter, :average
      @expected_month_to_quarter_avgs.each {|date, avg| aggregated_data.should include(date=>avg)}
      aggregated_data.should have(11).items
    end
  
    it "should aggregate monthly data into years using an average operation" do
      aggregated_data = @monthly_series_to_aggregate.aggregate_data_by :year, :average
      @expected_month_to_year_avgs.each {|date, avg| aggregated_data.should include(date=>avg)}
      aggregated_data.should have(2).items
    end
    
    it "should aggregate monthly data into semi_annuals using a average operation" do
      aggregated_data = @monthly_series_to_aggregate.aggregate_data_by :semi, :average
      @expected_month_to_semi_avgs.each {|date, sum| aggregated_data.should include(date=>sum)}
      aggregated_data.should have(5).items
    end

    it "should aggregate quarterly data into years using a sum operation" do
      aggregated_data = @quarterly_series_to_aggregate.aggregate_data_by :year, :sum
      @expected_quarter_to_year_sums.each {|date, sum| aggregated_data.should include(date=>sum)}
      aggregated_data.should have(2).items
    end
  
    it "should aggregated quarterly data into years using an average operation" do
      aggregated_data = @quarterly_series_to_aggregate.aggregate_data_by :year, :average
      @expected_quarter_to_year_avgs.each {|date, avg| aggregated_data.should include(date=>avg)}
      aggregated_data.should have(2).items
    end

    it "should aggregate semi_annual data into years using a sum operation" do
      aggregated_data = @semi_annual_series_to_aggregate.aggregate_data_by :year, :sum
      @expected_semi_to_year_sums.each {|date, sum| aggregated_data.should include(date=>sum)}
      aggregated_data.should have(5).items
    end
  
    it "should aggregated semi_annual data into years using an average operation" do
      aggregated_data = @semi_annual_series_to_aggregate.aggregate_data_by :year, :average
      @expected_semi_to_year_avgs.each {|date, avg| aggregated_data.should include(date=>avg)}
      aggregated_data.should have(5).items
    end
    
    it "should raise an AggregationException when attempting to aggregate monthly data by month" do
      lambda {@monthly_series_to_aggregate.group_data_by(:month)}.should raise_error AggregationException
    end

    it "should raise an AggregationException when attempting to aggregate quarterly data by quarter" do
      lambda {@quarterly_series_to_aggregate.group_data_by(:quarter)}.should raise_error AggregationException
    end
  
    it "should raise an AggregationException when attempting to aggregate quarterly data by month " do
      lambda {@quarterly_series_to_aggregate.group_data_by(:month)}.should raise_error AggregationException
    end
    
    it "should raise an AggregationException when attempting to aggregate semi_annual data by month " do
      lambda {@semi_annual_series_to_aggregate.group_data_by(:month)}.should raise_error AggregationException
    end

    it "should raise an AggregationException when attempting to aggregate semi_annual data by quarter " do
      lambda {@semi_annual_series_to_aggregate.group_data_by(:quarter)}.should raise_error AggregationException
    end
    
    it "should raise an AggregationException for attempting to aggregate annual data by any frequency" do
      lambda {@annual_series_to_aggregate.aggregate_data_by(:year, :sum)}.should raise_error AggregationException
    end
  end
end