class DashboardsController < ApplicationController
  def index
    @series_count = Series.count
    @aremos_series_count = AremosSeries.count
    @not_in_db = (AremosSeries.all_names - Series.all_names).count
    @in_db = @aremos_series_count - @not_in_db
    @frequency_counts = Series.frequency_counts
    @region_counts = Series.region_counts
    
    @a_counts = Series.last_observation_buckets("year")
    @s_counts = Series.last_observation_buckets("semi")
    @q_counts = Series.last_observation_buckets("quarter")
    @m_counts = @q_counts
    #@m_counts = Series.last_observation_buckets("month")
    
    @data_source_count = DataSource.count
    @type_buckets = DataSource.type_buckets
    #don't want to show the loads, only the transformations
    @sa_count = @type_buckets.delete :sa_load
    @load_count = @type_buckets.delete(:load) + @sa_count + @type_buckets[:mean_corrected_load]
  end
  
  def investigate
    #@maybe_ok_count = Series.where("aremos_missing = 0 AND ABS(aremos_diff) < 0.1 AND ABS(aremos_diff) > 0.0").count
    @maybe_ok = Series.where("aremos_missing = 0 AND ABS(aremos_diff) < 1.0 AND ABS(aremos_diff) > 0.0").order('aremos_diff DESC')
    
    
    #@wrong_count = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 0.1 AND ABS(aremos_diff) < 1000").count
    @wrong = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 1.0").order('aremos_diff DESC')
    
    #@way_off_count = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 1000").count
    #@way_off = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 1000").limit(20)
    
    #Series.where(:aremos_missing => '> 0').count
    #@missing_count = Series.where("aremos_missing > 0").count
    @missing_low_to_high = Series.where("aremos_missing > 0").order('aremos_missing ASC')
    #@missing_high_to_low = Series.where("aremos_missing > 0").order('aremos_missing DESC').limit(10)
  end
  
  def mapping
    @exempted = DataSource.all_history_and_manual_series_names
    @pattern = DataSource.all_pattern_series_names - @exempted
    @load = DataSource.all_load_from_file_series_names - @exempted
    @pattern_only = (@pattern - @load)
    @load_only = (@load - @pattern)
    @pattern_and_load = (@pattern & @load)
  end
  
  
end

#kinds of series
# all ok - 0 diff, 0 missing
# off by a little - 0 missing, diff < .1
# off by a little more - 0 missing .1 < diff < 1000
# probably a multiple - 0 missing diff > 1000
# missing values, high to low and low to high

#special situations
#only has one source, read, but still missing or off
#missing or off with no dependencies, but dependents
#missing or of, but dependencies are all ok

