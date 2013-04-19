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
  
  def broken_data_sources
    #this is also in the rake file. May want to match
    @inactive_ds = DataSource.where("FROM_DAYS(719528 + (last_run_in_seconds / 3600 - 10) / 24)  < FROM_DAYS(TO_DAYS(NOW()))").order(:last_run_in_seconds)
  end

  def search_data_sources
    #this is also in the rake file. May want to match
    @inactive_ds = DataSource.where("eval LIKE '%LF@hiwi.org%'").each {|ds| ds.print_eval_statement}
    render "broken_data_sources"
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
  
  def employment_hon
    @series_to_chart = [
    'E_NF@HON.M',
    'E_PR@HON.M',
    'ECT@HON.M',
    'EMN@HON.M',
    'EWT@HON.M',
    'ERT@HON.M',
    'E_TU@HON.M',
    'EIF@HON.M',
    'EFI@HON.M',
    'ERE@HON.M',
    'EPS@HON.M',
    'EMA@HON.M',
    'EAD@HON.M',
    'EED@HON.M',
    'EHC@HON.M',
    'EAF@HON.M',
    'EAFAC@HON.M',
    'EAFFD@HON.M',
    'EOS@HON.M',
    'EGV@HON.M',
    'EGVFD@HON.M',
    'EGVST@HON.M',
    'EGVLC@HON.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def employment_haw
    @series_to_chart = [
    'E_NF@HAW.M',
    'E_PR@HAW.M',
    'ECT@HAW.M',
    'EMN@HAW.M',
    'EWT@HAW.M',
    'ERT@HAW.M',
    'E_TU@HAW.M',
    'EIF@HAW.M',
    'EFI@HAW.M',
    'ERE@HAW.M',
    'EPS@HAW.M',
    'EMA@HAW.M',
    'EAD@HAW.M',
    'EED@HAW.M',
    'EHC@HAW.M',
    'EAF@HAW.M',
    'EAFAC@HAW.M',
    'EAFFD@HAW.M',
    'EOS@HAW.M',
    'EGV@HAW.M',
    'EGVFD@HAW.M',
    'EGVST@HAW.M',
    'EGVLC@HAW.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  
  def employment_mau
    @series_to_chart = [
    'E_NF@MAU.M',
    'E_PR@MAU.M',
    'ECT@MAU.M',
    'EMN@MAU.M',
    'EWT@MAU.M',
    'ERT@MAU.M',
    'E_TU@MAU.M',
    'EIF@MAU.M',
    'EFI@MAU.M',
    'ERE@MAU.M',
    'EPS@MAU.M',
    'EMA@MAU.M',
    'EAD@MAU.M',
    'EED@MAU.M',
    'EHC@MAU.M',
    'EAF@MAU.M',
    'EAFAC@MAU.M',
    'EAFFD@MAU.M',
    'EOS@MAU.M',
    'EGV@MAU.M',
    'EGVFD@MAU.M',
    'EGVST@MAU.M',
    'EGVLC@MAU.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  
  def employment_kau
    @series_to_chart = [
    'E_NF@KAU.M',
    'E_PR@KAU.M',
    'ECT@KAU.M',
    'EMN@KAU.M',
    'EWT@KAU.M',
    'ERT@KAU.M',
    'E_TU@KAU.M',
    'EIF@KAU.M',
    'EFI@KAU.M',
    'ERE@KAU.M',
    'EPS@KAU.M',
    'EMA@KAU.M',
    'EAD@KAU.M',
    'EED@KAU.M',
    'EHC@KAU.M',
    'EAF@KAU.M',
    'EAFAC@KAU.M',
    'EAFFD@KAU.M',
    'EOS@KAU.M',
    'EGV@KAU.M',
    'EGVFD@KAU.M',
    'EGVST@KAU.M',
    'EGVLC@KAU.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end

  def income
    @series_to_chart = [
    'Y@HI.Q',
    'YL@HI.Q',
    'YLAD@HI.Q',
    'YLAE@HI.Q',
    'YLAF@HI.Q',
    'YLAGFA@HI.Q',
    'YLAGFF@HI.Q',
    'YLCT@HI.Q',
    'YLED@HI.Q',
    'YLFI@HI.Q',
    'YLGV@HI.Q',
    'YLGVFD@HI.Q',
    'YLGVML@HI.Q',
    'YLHC@HI.Q',
    'YLIF@HI.Q',
    'YLMA@HI.Q',
    'YLMI@HI.Q',
    'YLMN@HI.Q',
    'YLMNDR@HI.Q',
    'YLMNND@HI.Q',
    'YLOS@HI.Q',
    'YLPS@HI.Q',
    'YLRE@HI.Q',
    'YLRT@HI.Q',
    'YLTW@HI.Q',
    'YLUT@HI.Q',
    'YLWT@HI.Q',
    'YL_GVSL@HI.Q',
    'YL_NF@HI.Q',
    'YL_PR@HI.Q',
    ]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def income_r
    @series_to_chart = [
    'Y_R@HI.Q',
    'YL_R@HI.Q',
    'YLAD_R@HI.Q',
    'YLAE_R@HI.Q',
    'YLAF_R@HI.Q',
    'YLAGFA_R@HI.Q',
    'YLAGFF_R@HI.Q',
    'YLCT_R@HI.Q',
    'YLED_R@HI.Q',
    'YLFI_R@HI.Q',
    'YLGV_R@HI.Q',
    'YLGVFD_R@HI.Q',
    'YLGVML_R@HI.Q',
    'YLHC_R@HI.Q',
    'YLIF_R@HI.Q',
    'YLMA_R@HI.Q',
    'YLMI_R@HI.Q',
    'YLMN_R@HI.Q',
    'YLMNDR_R@HI.Q',
    'YLMNND_R@HI.Q',
    'YLOS_R@HI.Q',
    'YLPS_R@HI.Q',
    'YLRE_R@HI.Q',
    'YLRT_R@HI.Q',
    'YLTW_R@HI.Q',
    'YLUT_R@HI.Q',
    'YLWT_R@HI.Q',
    'YL_GVSL_R@HI.Q',
    'YL_NF_R@HI.Q',
    'YL_PR_R@HI.Q',
    ]
    dates = set_dates_q(params)
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

