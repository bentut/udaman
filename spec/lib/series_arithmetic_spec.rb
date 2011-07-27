require 'spec_helper'
require 'spec_data_hash.rb'

describe SeriesArithmetic do

  before(:all) do
    @dh = get_data_hash
  end
  
  describe "performing series ARITHMETIC" do
    before(:all) do
      
      @monthly_series_to_aggregate = Series.create_dummy("monthly_test_series", :month, "2000-05-01", 1, 36)
      @quarterly_series_to_aggregate = Series.create_dummy("quarterly_test_series", :quarter, "2000-04-01", 1, 12)
      @semi_annual_series_to_aggregate = Series.create_dummy("semi_test_series", :semi, "2000-07-01", 1, 11)
      @annual_series_to_aggregate = Series.create_dummy("annual_test_series", :year, "2000-01-01", 1, 12)
      
      @dollars_series = Series.create(:name => "dollars_series",:frequency => :month, :units=>1)
      @people_series = Series.create(:name => "people_series",:frequency => :month, :units=>1000)
      @monthly_series = Series.create(:name => "monthly_test_series")
      @quarterly_series = Series.create(:name => "quarterly_test_series")
    end
    it "should raise a SeriesArithmeticException when you try to two series with different units" do
      lambda {@dollars_series + @people_series}.should raise_error SeriesArithmeticException
    end
  
    it "should raise a SeriesArithmeticException when you try to subtract two series with different units" do
      lambda {@dollars_series - @people_series}.should raise_error SeriesArithmeticException
    end
  
    it "should raise a SeriesArithmeticException when a series tests the arithmetic validity of a series with a different frequency" do
      lambda {@monthly_series_to_aggregate.validate_arithmetic(@quarterly_series_to_aggregate)}.should raise_error SeriesArithmeticException
    end
  
    it "should raise a SeriesArithmeticException when a series tests the arithmetic validity of another series and at least one does not have a frequency defined" do
      lambda {@monthly_series.validate_arithmetic(@quarterly_series)}.should raise_error SeriesArithmeticException
    end
  
    it "should create a series where the name of the series is the summary of the operations" do
      ones        = @dh.ns("ONES@TEST.Q")
      ones_hist   = @dh.ns("ONES_HIST@TEST.Q") 
      (ones + ones_hist).name.should == "ONES@TEST.Q + ONES_HIST@TEST.Q"
    end
  
    it "should fill in a series with 0s for all null values if +_ is used" do
      blank_ones    = @dh.ns "BLANK_ONES@TEST.Q"
      blanks        = @dh.ns "BLANKS@TEST.Q"
      blanks_merge  = @dh.ns "BLANKS_MERGE@TEST.Q"
      (blank_ones.zero_add blanks).identical_to?(blanks_merge.data).should be_true
    end
  end
  
  describe "ROUNDING series values" do
    it "should round all values in a series to 0 decimal places" do
      annual_sum_rd   = @dh.ns "ANNUAL_SUM_RD@TEST.M"
      annual_sum      = @dh.ns "ANNUAL_SUM@TEST.M"
      annual_sum_rd.identical_to?(annual_sum.round.data).should be_true
    end
  end
  
  describe "calculating an ANNUAL SUM" do
    it "should successfully calculate an annual sum" do
      annual_sum  = @dh.ns "ANNUAL_SUM@TEST.M"
      to_mov_avg  = @dh.ns "TO_AVG@TEST.M"
      annual_sum.identical_to?(to_mov_avg.annual_sum.data).should be_true
    end
    
    it "should successfully calculate an annual sum at quarterly frequency" do      
      ones_annual_sum = @dh.ns "ONES_ANNUAL_SUM@TEST.Q"
      ones_copy       = @dh.ns "ONES@TEST.Q"
      ones_annual_sum.identical_to?(ones_copy.annual_sum.data).should be_true
    end
  end
  
  describe "calculating a ANNUAL AVERAGE" do
    it "should succesfully calculate an annual average" do
      annual_avg  = @dh.ns "ANNUAL_AVG@TEST.M"
      to_mov_avg  = @dh.ns "TO_AVG@TEST.M"
      annual_avg.identical_to?(to_mov_avg.annual_average.data).should be_true
    end
  end
  
  describe "calculating a MOVING AVERAGE" do
    it "should raise an error if there are fewer than 18 values" do
    end
    it "should successfully calculate a moving average" do
       to_mov_avg  = @dh.ns "TO_AVG@TEST.M"
       mov_avg    = @dh.ns "AVG@TEST.M"
       mov_avg.identical_to?(to_mov_avg.moving_average.data).should be_true
    end
    
    describe "calculating a BACKWARD LOOKING MOVING AVERAGE" do
      it "should successfully calculate a moving average" do
        bl_mov_avg    = @dh.ns "BL_MA@TEST.M"
        to_bl_mov_avg = @dh.ns "TO_AVG@TEST.M"
        bl_mov_avg.identical_to?(to_bl_mov_avg.backward_looking_moving_average.data).should be_true
      end
    end
    
    describe "calculating a FORWARD LOOKING MOVING AVERAGE" do
      it "should successfully calculate a moving average" do
        fl_mov_avg    = @dh.ns "FL_MA@TEST.M"
        to_bl_mov_avg = @dh.ns "TO_AVG@TEST.M"
        fl_mov_avg.identical_to?(to_bl_mov_avg.forward_looking_moving_average.data).should be_true
      end
    end
    
    describe "calculating a OFFEST BY 1 FORWARD LOOKING MOVING AVERAGE" do
      it "should successfully calculate a moving average" do
        fl1_mov_avg    = @dh.ns "FL1_MA@TEST.M"
        to_bl_mov_avg = @dh.ns "TO_AVG@TEST.M"
        fl1_mov_avg.identical_to?(to_bl_mov_avg.offset_forward_looking_moving_average.data).should be_true
      end
    end
  end
  
  describe "calculating PERCENTAGE CHANGE" do
    it "should raise an error if there are fewer than 2 values" do
    end
    
    it "should successfully calculate percentage change" do
      per_change = @dh.ns "PER_CHANGE@TEST.M"
      to_mov_avg  = @dh.ns "TO_AVG@TEST.M"
      per_change.identical_to?(to_mov_avg.percentage_change.data).should be_true
    end
    
    it "should successfully calculate annualized percentage change" do
      annualized_change   = @dh.ns "ANNUALIZED_CHANGE@TEST.Q"
      data_q              = @dh.ns "DATA@TEST.Q"
      annualized_change.identical_to?(data_q.annualized_percentage_change.data).should be_true
    end
  end
  
  describe "REBASING series to a particular date" do
    it "should successfully rebase a series to the value at a particular date" do
      data_q  = @dh.ns "DATA@TEST.Q"
      rebase  = @dh.ns "REBASE_JAN1989@TEST.Q"
      rebase.identical_to?(data_q.rebase("1989-01-01").data).should be_true
    end
  end
  
  
end