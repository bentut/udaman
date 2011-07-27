require 'spec_helper'
require 'spec_data_hash.rb'

describe SeriesSeasonalAdjustment do

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
  
  describe "performing SEASONAL ADJUSTMENT UPDATES" do
    before(:each) do
      
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
      
      # Series.all.each {|s| puts s.name}
      # puts "------------"
      @ns_series_loaded.save
      # Series.all.each {|s| puts s.name}
      # puts "------------"
      @sa_series_loaded.save
      @ns_series = @ns_series_name.ts
      # Series.all.each {|s| puts s.name}
      # puts "------------"
      @sa_series = @sa_series_name.ts
    end
  
    it "should find 12 date, value pairs to derive factors from in its data array." do
      @ns_series.should_not be_nil
      last_demetra_date = Date.parse @sa_series.last_demetra_datestring
      factor_comparison_start_date = last_demetra_date << 12
      last_year_of_sa_values = @sa_series.get_values_after(factor_comparison_start_date.to_s)
      last_year_of_sa_values.should have(12).items
    end
  
    it "should generate expected factors from a seasonally adjusted series and its counterpart." do
      @ns_series.save
      @sa_series.set_factors :additive
      @sa_series.factors.should have(12).items
      @sa_series.factors["1"].should be_within(0.005).of(-0.41432)
      @sa_series.factors["2"].should be_within(0.005).of(0.054157)
      @sa_series.factors["3"].should be_within(0.005).of(0.080062)
      @sa_series.factors["4"].should be_within(0.005).of(-0.04275)
      @sa_series.factors["5"].should be_within(0.005).of(0.348443)
      @sa_series.factors["6"].should be_within(0.005).of(0.276722)
      @sa_series.factors["7"].should be_within(0.005).of(-0.19573)
      @sa_series.factors["8"].should be_within(0.005).of(-0.09403)
      @sa_series.factors["9"].should be_within(0.005).of(-0.07892)
      @sa_series.factors["10"].should be_within(0.005).of(-0.22735)
      @sa_series.factors["11"].should be_within(0.005).of(0.046368)
      @sa_series.factors["12"].should be_within(0.005).of(0.205269)
      @sa_series.factor_application.should == :additive
      #@sa_series.factors.should include("2009-01-01"=>-0.41432)
    end
  
    it "should update the series with the expected values" do
      @ns_series.save
      @sa_series.data = @sa_series.apply_seasonal_adjustment(:additive).data
      observed_values_since_seasonal_adjustment = @sa_series.get_values_after(@sa_series.last_demetra_datestring)
      observed_values_since_seasonal_adjustment.should have(7).items
      @sa_series.data["2010-01-01"].should be_within(0.005).of(9.01432223)
      @sa_series.data["2010-02-01"].should be_within(0.005).of(8.64584337)
      @sa_series.data["2010-03-01"].should be_within(0.005).of(8.61993758)
      @sa_series.data["2010-04-01"].should be_within(0.005).of(8.64275073)
      @sa_series.data["2010-05-01"].should be_within(0.005).of(8.45155745)
      @sa_series.data["2010-06-01"].should be_within(0.005).of(8.62327841)
      @sa_series.data["2010-07-01"].should be_within(0.005).of(8.49573035)
    
    end
  end
end
