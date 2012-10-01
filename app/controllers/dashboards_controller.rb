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
    #@wrong_count = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 0.1 AND ABS(aremos_diff) < 1000").count
    #@way_off_count = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 1000").count
    #@way_off = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 1000").limit(20)
    #Series.where(:aremos_missing => '> 0').count
    #@missing_count = Series.where("aremos_missing > 0").count
    #@missing_high_to_low = Series.where("aremos_missing > 0").order('aremos_missing DESC').limit(10)
    
    @maybe_ok = Series.where("aremos_missing = 0 AND ABS(aremos_diff) < 1.0 AND ABS(aremos_diff) > 0.0").order('aremos_diff DESC')   
    @wrong = Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 1.0").order('aremos_diff DESC')
    @missing_low_to_high = Series.where("aremos_missing > 0").order('aremos_missing ASC')
    
    handle_hash = DataSource.handle_hash
    @maybe_ok_buckets = Series.handle_buckets(@maybe_ok, handle_hash)
    @wrong_buckets = Series.handle_buckets(@wrong, handle_hash)
    @missing_low_to_high_buckets = Series.handle_buckets(@missing_low_to_high, handle_hash)
    
    @bucket_keys = (@maybe_ok_buckets.keys + @wrong_buckets.keys + @missing_low_to_high_buckets.keys).uniq
  end
  
  def investigate_visual
    @diff_data = []
    @to_investigate = Series.where("aremos_missing > 0 OR ABS(aremos_diff) > 0.0").order('name ASC')
  end
  
  def rake_report
  end
  
  def investigate_no_source
    #@no_source = DataSource.where("eval NOT LIKE '%load_from_download%'").select([:eval, :series_id]).joins("JOIN series ON series.id = series_id").where("aremos_missing > 0 OR ABS(aremos_diff) > 0").group(:name).all.sort

    @no_source = Series.where("aremos_missing > 0 OR ABS(aremos_diff) > 0").joins("JOIN data_sources ON series.id = series_id").where("eval NOT LIKE '%load_from_download%'").group(:name).order(:name).all
  end
  
  def mapping
    @exempted = DataSource.all_history_and_manual_series_names
    @pattern = DataSource.all_pattern_series_names - @exempted
    @load = DataSource.all_load_from_file_series_names - @exempted
    @pattern_only = (@pattern - @load)
    @load_only = (@load - @pattern)
    @pattern_and_load = (@pattern & @load)
  end
  
  def d_cache
    #begin
      @cache = Series.get_cached_files
      #@xls_count = @cache.get_cache[:xls].count
      #@cache = Series.open_cached_files if @cache.nil?
    #rescue NameError => e
      #@cache = Series.open_cached_files
    #end
  end
    
  def construction
    @series_to_chart = ['KPPRVNS@HI.M',
    'KPPRVADDNS@HI.M',
    'KPPRVRSDNS@HI.M',
    'KPPRVCOMNS@HI.M',
    'KPPRVNS@HON.M',
    'KPPRVADDNS@HON.M',
    'KPPRVRSDNS@HON.M',
    'KPPRVCOMNS@HON.M',
    'KPPRVNS@HAW.M',
    'KPPRVADDNS@HAW.M',
    'KPPRVRSDNS@HAW.M',
    'KPPRVCOMNS@HAW.M',
    'KPPRVNS@MAU.M',
    'KPPRVADDNS@MAU.M',
    'KPPRVRSDNS@MAU.M',
    'KPPRVCOMNS@MAU.M',
    'KPPRVNS@KAU.M',
    'KPPRVADDNS@KAU.M',
    'KPPRVRSDNS@KAU.M',
    'KPPRVCOMNS@KAU.M',]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "construction"
  end

  def construction_quarterly
    @series_to_chart = [
    'KPGOVNS@HI.Q',
    'KPNS@HI.Q',
    'KPGOVNS@HON.Q',
    'KPNS@HON.Q',
    'KPGOVNS@HAW.Q',
    'KPNS@HAW.Q',
    'KPGOVNS@MAU.Q',
    'KPNS@MAU.Q',
    'KPGOVNS@KAU.Q',
    'KPNS@KAU.Q',
    'PICTSGFNS@HON.Q',
    'PICTCONNS@HON.Q',
    'PICTSGFNS@US.Q',
    'KNRSDNS@HI.Q',
    'KNRSDSGFNS@HI.Q',
    'KNRSDMLTNS@HI.Q']
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "construction"
  end
  
  
  def hbr_mbr
    @series_to_chart = ['KBSGFNS@HON.M',
    'KBCONNS@HON.M',
    'PMKBSGFNS@HON.M',
    'PMKBCONNS@HON.M',
    'KBSGFNS@MAU.M',
    'KBCONNS@MAU.M',
    'PMKBSGFNS@MAU.M',
    'PMKBCONNS@MAU.M',
    'KBSGF@HON.M',
    'KBCON@HON.M',
    'PMKBSGF@HON.M',
    'PMKBCON@HON.M',
    'KBSGF@MAU.M',
    'KBCON@MAU.M',
    'PMKBSGF@MAU.M',
    'PMKBCON@MAU.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "construction"
  end
  
  def permits
    @series_to_chart = ['KNNSGF@HON.M',
    'KNN2FM@HON.M',
    'KNNAPT@HON.M',
    'KNNHTL@HON.M',
    'KNNAMU@HON.M',
    'KNNCHU@HON.M',
    'KNNIND@HON.M',
    'KNNGPB@HON.M',
    'KNNGPR@HON.M',
    'KNNSER@HON.M',
    'KNNINS@HON.M',
    'KNNOFC@HON.M',
    'KNNPBB@HON.M',
    'KNNPBU@HON.M',
    'KNNSCH@HON.M',
    'KNNSHD@HON.M',
    'KNNSTB@HON.M',
    'KNNSTR@HON.M',
    'KNNONR@HON.M',
    'KNNOTH@HON.M',
    'KNN@HON.M',
    'KNASGF@HON.M',
    'KNA2FM@HON.M',
    'KNAAPT@HON.M',
    'KNAHTL@HON.M',
    'KNAAMU@HON.M',
    'KNACHU@HON.M',
    'KNAIND@HON.M',
    'KNAGPB@HON.M',
    'KNAGPR@HON.M',
    'KNASER@HON.M',
    'KNAINS@HON.M',
    'KNAOFC@HON.M',
    'KNAPBB@HON.M',
    'KNAPBU@HON.M',
    'KNASCH@HON.M',
    'KNASHD@HON.M',
    'KNASTB@HON.M',
    'KNASTR@HON.M',
    'KNAONR@HON.M',
    'KNAOTH@HON.M',
    'KNA@HON.M',
    'KVNSGF@HON.M',
    'KVN2FM@HON.M',
    'KVNAPT@HON.M',
    'KVNHTL@HON.M',
    'KVNAMU@HON.M',
    'KVNCHU@HON.M',
    'KVNIND@HON.M',
    'KVNGPB@HON.M',
    'KVNGPR@HON.M',
    'KVNSER@HON.M',
    'KVNINS@HON.M',
    'KVNOFC@HON.M',
    'KVNPBB@HON.M',
    'KVNPBU@HON.M',
    'KVNSCH@HON.M',
    'KVNSHD@HON.M',
    'KVNSTB@HON.M',
    'KVNSTR@HON.M',
    'KVNONR@HON.M',
    'KVNOTH@HON.M',
    'KVN@HON.M',
    'KVASGF@HON.M',
    'KVA2FM@HON.M',
    'KVAAPT@HON.M',
    'KVAHTL@HON.M',
    'KVAAMU@HON.M',
    'KVACHU@HON.M',
    'KVAIND@HON.M',
    'KVAGPB@HON.M',
    'KVAGPR@HON.M',
    'KVASER@HON.M',
    'KVAINS@HON.M',
    'KVAOFC@HON.M',
    'KVAPBB@HON.M',
    'KVAPBU@HON.M',
    'KVASCH@HON.M',
    'KVASHD@HON.M',
    'KVASTB@HON.M',
    'KVASTR@HON.M',
    'KVAONR@HON.M',
    'KVAOTH@HON.M',
    'KVA@HON.M',]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "construction"
  end
  
  def prudential
    @series_to_chart = ['PMKRSGF@HON.Q',
    'PMKRCON@HON.Q',
    'PAKRSGF@HON.Q',
    'PAKRCON@HON.Q',
    'KRSGFNS@HON.Q',
    'KRCONNS@HON.Q',
    'PMKRSGF@HI.Q',
    'PMKRCON@HI.Q',
    'PAKRSGF@HI.Q',
    'PAKRCON@HI.Q',
    'KRSGFNS@HI.Q',
    'KRCONNS@HI.Q',
    'PMKRSGF@HAW.Q',
    'PMKRCON@HAW.Q',
    'PAKRSGF@HAW.Q',
    'PAKRCON@HAW.Q',
    'KRSGFNS@HAW.Q',
    'KRCONNS@HAW.Q',
    'PMKRSGF@KAU.Q',
    'PMKRCON@KAU.Q',
    'PAKRSGF@KAU.Q',
    'PAKRCON@KAU.Q',
    'KRSGFNS@KAU.Q',
    'KRCONNS@KAU.Q',
    'PMKRSGF@MAU.Q',
    'PMKRCON@MAU.Q',
    'PAKRSGF@MAU.Q',
    'PAKRCON@MAU.Q',
    'KRSGFNS@MAU.Q',
    'KRCONNS@MAU.Q',]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "construction"
  end
  
  def employment
    @series_to_chart = [
    'E_NF@HI.M',
    'E_PR@HI.M',
    'ECT@HI.M',
    'EMN@HI.M',
    'EWT@HI.M',
    'ERT@HI.M',
    'E_TU@HI.M',
    'EIF@HI.M',
    'EFI@HI.M',
    'ERE@HI.M',
    'EPS@HI.M',
    'EMA@HI.M',
    'EAD@HI.M',
    'EED@HI.M',
    'EHC@HI.M',
    'EAF@HI.M',
    'EAFAC@HI.M',
    'EAFFD@HI.M',
    'EOS@HI.M',
    'EGV@HI.M',
    'EGVFD@HI.M',
    'EGVST@HI.M',
    'EGVLC@HI.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def employment_us
    @series_to_chart = [
    'E_NF@US.M',
    'E_PR@US.M',
    'ECT@US.M',
    'EMN@US.M',
    'EWT@US.M',
    'ERT@US.M',
    'E_TU@US.M',
    'EIF@US.M',
    'EFI@US.M',
    'ERE@US.M',
    'EPS@US.M',
    'EMA@US.M',
    'EAD@US.M',
    'EED@US.M',
    'EHC@US.M',
    'EAF@US.M',
    'EAFAC@US.M',
    'EAFFD@US.M',
    'EOS@US.M',
    'EGV@US.M',
    'EGVFD@US.M',
    'EGVST@US.M',
    'EGVLC@US.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
private
  def set_dates_m(params)
    if params[:num_years].nil?
      start_date = (Time.now.to_date << (15)).to_s
      end_date = nil
    else
      start_date = (Time.now.to_date << (12 * params[:num_years].to_i + 1)).to_s
      end_date = nil
    end
    return {:start_date => start_date, :end_date => end_date}
  end

  def set_dates_q(params)
    if params[:num_years].nil?
      start_date = (Time.now.to_date << (34)).to_s
      end_date = nil
    else
      start_date = (Time.now.to_date << (12 * params[:num_years].to_i + 4)).to_s
      end_date = nil
    end
    return {:start_date => start_date, :end_date => end_date}
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

