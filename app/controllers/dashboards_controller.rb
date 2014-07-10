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

  def udamacmini_comparison
    client = HTTPClient.new
    resp = client.get("http://s9n196.soc.hawaii.edu:3000/system_summary.csv")
    open("public/udamacmini_system_summary.csv", "wb") { |file| file.write resp.content }
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
  
  def tax_m
    @series_to_chart = [
    "TRNS_FISCAL_YTD@HI.M",
    "TGRNS_FISCAL_YTD@HI.M",
    "TRHSNS_FISCAL_YTD@HI.M",
    "TRTTNS_FISCAL_YTD@HI.M",
    #{}"TRIINS_FISCAL_YTD@HI.M",
    "TRCONS_FISCAL_YTD@HI.M",
    "TDGFNS_FISCAL_YTD@HI.M",
    "TGRNS_FISCAL_YTD@HI.M",
    "TGRRTNS_FISCAL_YTD@HI.M",
    "TGRSVNS_FISCAL_YTD@HI.M",
    "TGRCTNS_FISCAL_YTD@HI.M",
    "TGRHTNS_FISCAL_YTD@HI.M",
    "TGRORNS_FISCAL_YTD@HI.M",
    "TGRWTNS_FISCAL_YTD@HI.M",
    "TGBNS_FISCAL_YTD@HI.M",
    "TGBRTNS_FISCAL_YTD@HI.M",
    "TGBSVNS_FISCAL_YTD@HI.M",
    "TGBCTNS_FISCAL_YTD@HI.M",
    "TGBHTNS_FISCAL_YTD@HI.M",
    "TGBORNS_FISCAL_YTD@HI.M",
    "TGBWTNS_FISCAL_YTD@HI.M"
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_mau_m
    @series_to_chart = [
      'VIS@MAU.M',
      'VISUS@MAU.M',
      'VISJP@MAU.M',
      'VISCAN@MAU.M',
      'VISRES@MAU.M',
      'VDAY@MAU.M',
      'VDAYUS@MAU.M',
      'VDAYJP@MAU.M',
      'VDAYCAN@MAU.M',
      'VDAYRES@MAU.M',
      'VLOS@MAU.M',
      'VLOSUS@MAU.M',
      'VLOSJP@MAU.M',
      'VLOSCAN@MAU.M',
      'VLOSRES@MAU.M',
      'VEXP@MAU.M',
      'VEXPUS@MAU.M',
      'VEXPJP@MAU.M',
      'VEXPCAN@MAU.M',
      'VEXPOT@MAU.M',
      'VEXPPD@MAU.M',
      'VEXPPDUS@MAU.M',
      'VEXPPDJP@MAU.M',
      'VEXPPDCAN@MAU.M',
      'VEXPPDOT@MAU.M',
      'VEXPPT@MAU.M',
      'VEXPPTUS@MAU.M',
      'VEXPPTJP@MAU.M',
      'VEXPPTCAN@MAU.M',
      'VEXPPTOT@MAU.M',
      'VS@MAU.M',
      'VSDM@MAU.M',
      'VSIT@MAU.M',
      'OCUP%@MAU.M',
      'PRM@MAU.M',
      'RMRV@MAU.M',
      'E_LH@MAU.M',
      'E_AF@MAU.M',
      'EAE@MAU.M',
      'EAFFAC@MAU.M',
      'EAFFD@MAU.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_hon_m
    @series_to_chart = [
      'VIS@HON.M',
      'VISUS@HON.M',
      'VISJP@HON.M',
      'VISCAN@HON.M',
      'VISRES@HON.M',
      'VDAY@HON.M',
      'VDAYUS@HON.M',
      'VDAYJP@HON.M',
      'VDAYCAN@HON.M',
      'VDAYRES@HON.M',
      'VLOS@HON.M',
      'VLOSUS@HON.M',
      'VLOSJP@HON.M',
      'VLOSCAN@HON.M',
      'VLOSRES@HON.M',
      'VEXP@HON.M',
      'VEXPUS@HON.M',
      'VEXPJP@HON.M',
      'VEXPCAN@HON.M',
      'VEXPOT@HON.M',
      'VEXPPD@HON.M',
      'VEXPPDUS@HON.M',
      'VEXPPDJP@HON.M',
      'VEXPPDCAN@HON.M',
      'VEXPPDOT@HON.M',
      'VEXPPT@HON.M',
      'VEXPPTUS@HON.M',
      'VEXPPTJP@HON.M',
      'VEXPPTCAN@HON.M',
      'VEXPPTOT@HON.M',
      'VS@HON.M',
      'VSDM@HON.M',
      'VSIT@HON.M',
      'OCUP%@HON.M',
      'PRM@HON.M',
      'RMRV@HON.M',
      'E_LH@HON.M',
      'E_AF@HON.M',
      'EAE@HON.M',
      'EAFFAC@HON.M',
      'EAFFD@HON.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_haw_m
    @series_to_chart = [
      'VIS@HAW.M',
      'VISUS@HAW.M',
      'VISJP@HAW.M',
      'VISCAN@HAW.M',
      'VISRES@HAW.M',
      'VDAY@HAW.M',
      'VDAYUS@HAW.M',
      'VDAYJP@HAW.M',
      'VDAYCAN@HAW.M',
      'VDAYRES@HAW.M',
      'VLOS@HAW.M',
      'VLOSUS@HAW.M',
      'VLOSJP@HAW.M',
      'VLOSCAN@HAW.M',
      'VLOSRES@HAW.M',
      'VEXP@HAW.M',
      'VEXPUS@HAW.M',
      'VEXPJP@HAW.M',
      'VEXPCAN@HAW.M',
      'VEXPOT@HAW.M',
      'VEXPPD@HAW.M',
      'VEXPPDUS@HAW.M',
      'VEXPPDJP@HAW.M',
      'VEXPPDCAN@HAW.M',
      'VEXPPDOT@HAW.M',
      'VEXPPT@HAW.M',
      'VEXPPTUS@HAW.M',
      'VEXPPTJP@HAW.M',
      'VEXPPTCAN@HAW.M',
      'VEXPPTOT@HAW.M',
      'VS@HAW.M',
      'VSDM@HAW.M',
      'VSIT@HAW.M',
      'OCUP%@HAW.M',
      'PRM@HAW.M',
      'RMRV@HAW.M',
      'E_LH@HAW.M',
      'E_AF@HAW.M',
      'EAE@HAW.M',
      'EAFFAC@HAW.M',
      'EAFFD@HAW.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_kau_m
    @series_to_chart = [
      'VIS@KAU.M',
      'VISUS@KAU.M',
      'VISJP@KAU.M',
      'VISCAN@KAU.M',
      'VISRES@KAU.M',
      'VDAY@KAU.M',
      'VDAYUS@KAU.M',
      'VDAYJP@KAU.M',
      'VDAYCAN@KAU.M',
      'VDAYRES@KAU.M',
      'VLOS@KAU.M',
      'VLOSUS@KAU.M',
      'VLOSJP@KAU.M',
      'VLOSCAN@KAU.M',
      'VLOSRES@KAU.M',
      'VEXP@KAU.M',
      'VEXPUS@KAU.M',
      'VEXPJP@KAU.M',
      'VEXPCAN@KAU.M',
      'VEXPOT@KAU.M',
      'VEXPPD@KAU.M',
      'VEXPPDUS@KAU.M',
      'VEXPPDJP@KAU.M',
      'VEXPPDCAN@KAU.M',
      'VEXPPDOT@KAU.M',
      'VEXPPT@KAU.M',
      'VEXPPTUS@KAU.M',
      'VEXPPTJP@KAU.M',
      'VEXPPTCAN@KAU.M',
      'VEXPPTOT@KAU.M',
      'VS@KAU.M',
      'VSDM@KAU.M',
      'VSIT@KAU.M',
      'OCUP%@KAU.M',
      'PRM@KAU.M',
      'RMRV@KAU.M',
      'E_LH@KAU.M',
      'E_AF@KAU.M',
      'EAE@KAU.M',
      'EAFFAC@KAU.M',
      'EAFFD@KAU.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_hi_m
    @series_to_chart = [
      'VIS@HI.M',
      'VISUS@HI.M',
      'VISJP@HI.M',
      'VISCAN@HI.M',
      'VISRES@HI.M',
      'VDAY@HI.M',
      'VDAYUS@HI.M',
      'VDAYJP@HI.M',
      'VDAYCAN@HI.M',
      'VDAYRES@HI.M',
      'VLOS@HI.M',
      'VLOSUS@HI.M',
      'VLOSJP@HI.M',
      'VLOSCAN@HI.M',
      'VLOSRES@HI.M',
      'VEXP@HI.M',
      'VEXPUS@HI.M',
      'VEXPJP@HI.M',
      'VEXPCAN@HI.M',
      'VEXPOT@HI.M',
      'VEXPPD@HI.M',
      'VEXPPDUS@HI.M',
      'VEXPPDJP@HI.M',
      'VEXPPDCAN@HI.M',
      'VEXPPDOT@HI.M',
      'VEXPPT@HI.M',
      'VEXPPTUS@HI.M',
      'VEXPPTJP@HI.M',
      'VEXPPTCAN@HI.M',
      'VEXPPTOT@HI.M',
      'VS@HI.M',
      'VSDM@HI.M',
      'VSIT@HI.M',
      'OCUP%@HI.M',
      'PRM@HI.M',
      'RMRV@HI.M',
      'E_LH@HI.M',
      'E_AF@HI.M',
      'EAE@HI.M',
      'EAFFAC@HI.M',
      'EAFFD@HI.M',
    ]
    dates = set_dates_m(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  
  def visitor_mau_q
    @series_to_chart = [
      'VIS@MAU.Q',
      'VISUS@MAU.Q',
      'VISJP@MAU.Q',
      'VISCAN@MAU.Q',
      'VISRES@MAU.Q',
      'VDAY@MAU.Q',
      'VDAYUS@MAU.Q',
      'VDAYJP@MAU.Q',
      'VDAYCAN@MAU.Q',
      'VDAYRES@MAU.Q',
      'VLOS@MAU.Q',
      'VLOSUS@MAU.Q',
      'VLOSJP@MAU.Q',
      'VLOSCAN@MAU.Q',
      'VLOSRES@MAU.Q',
      'VEXP@MAU.Q',
      'VEXPUS@MAU.Q',
      'VEXPJP@MAU.Q',
      'VEXPCAN@MAU.Q',
      'VEXPOT@MAU.Q',
      'VEXPPD@MAU.Q',
      'VEXPPDUS@MAU.Q',
      'VEXPPDJP@MAU.Q',
      'VEXPPDCAN@MAU.Q',
      'VEXPPDOT@MAU.Q',
      'VEXPPT@MAU.Q',
      'VEXPPTUS@MAU.Q',
      'VEXPPTJP@MAU.Q',
      'VEXPPTCAN@MAU.Q',
      'VEXPPTOT@MAU.Q',
      'VS@MAU.Q',
      'VSDM@MAU.Q',
      'VSIT@MAU.Q',
      'OCUP%@MAU.Q',
      'PRM@MAU.Q',
      'RMRV@MAU.Q',
      'E_LH@MAU.Q',
      'E_AF@MAU.Q',
      'EAE@MAU.Q',
      'EAFFAC@MAU.Q',
      'EAFFD@MAU.Q',
    ]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_hon_q
    @series_to_chart = [
      'VIS@HON.Q',
      'VISUS@HON.Q',
      'VISJP@HON.Q',
      'VISCAN@HON.Q',
      'VISRES@HON.Q',
      'VDAY@HON.Q',
      'VDAYUS@HON.Q',
      'VDAYJP@HON.Q',
      'VDAYCAN@HON.Q',
      'VDAYRES@HON.Q',
      'VLOS@HON.Q',
      'VLOSUS@HON.Q',
      'VLOSJP@HON.Q',
      'VLOSCAN@HON.Q',
      'VLOSRES@HON.Q',
      'VEXP@HON.Q',
      'VEXPUS@HON.Q',
      'VEXPJP@HON.Q',
      'VEXPCAN@HON.Q',
      'VEXPOT@HON.Q',
      'VEXPPD@HON.Q',
      'VEXPPDUS@HON.Q',
      'VEXPPDJP@HON.Q',
      'VEXPPDCAN@HON.Q',
      'VEXPPDOT@HON.Q',
      'VEXPPT@HON.Q',
      'VEXPPTUS@HON.Q',
      'VEXPPTJP@HON.Q',
      'VEXPPTCAN@HON.Q',
      'VEXPPTOT@HON.Q',
      'VS@HON.Q',
      'VSDM@HON.Q',
      'VSIT@HON.Q',
      'OCUP%@HON.Q',
      'PRM@HON.Q',
      'RMRV@HON.Q',
      'E_LH@HON.Q',
      'E_AF@HON.Q',
      'EAE@HON.Q',
      'EAFFAC@HON.Q',
      'EAFFD@HON.Q',
    ]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_haw_q
    @series_to_chart = [
      'VIS@HAW.Q',
      'VISUS@HAW.Q',
      'VISJP@HAW.Q',
      'VISCAN@HAW.Q',
      'VISRES@HAW.Q',
      'VDAY@HAW.Q',
      'VDAYUS@HAW.Q',
      'VDAYJP@HAW.Q',
      'VDAYCAN@HAW.Q',
      'VDAYRES@HAW.Q',
      'VLOS@HAW.Q',
      'VLOSUS@HAW.Q',
      'VLOSJP@HAW.Q',
      'VLOSCAN@HAW.Q',
      'VLOSRES@HAW.Q',
      'VEXP@HAW.Q',
      'VEXPUS@HAW.Q',
      'VEXPJP@HAW.Q',
      'VEXPCAN@HAW.Q',
      'VEXPOT@HAW.Q',
      'VEXPPD@HAW.Q',
      'VEXPPDUS@HAW.Q',
      'VEXPPDJP@HAW.Q',
      'VEXPPDCAN@HAW.Q',
      'VEXPPDOT@HAW.Q',
      'VEXPPT@HAW.Q',
      'VEXPPTUS@HAW.Q',
      'VEXPPTJP@HAW.Q',
      'VEXPPTCAN@HAW.Q',
      'VEXPPTOT@HAW.Q',
      'VS@HAW.Q',
      'VSDM@HAW.Q',
      'VSIT@HAW.Q',
      'OCUP%@HAW.Q',
      'PRM@HAW.Q',
      'RMRV@HAW.Q',
      'E_LH@HAW.Q',
      'E_AF@HAW.Q',
      'EAE@HAW.Q',
      'EAFFAC@HAW.Q',
      'EAFFD@HAW.Q',
    ]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_kau_q
    @series_to_chart = [
      'VIS@KAU.Q',
      'VISUS@KAU.Q',
      'VISJP@KAU.Q',
      'VISCAN@KAU.Q',
      'VISRES@KAU.Q',
      'VDAY@KAU.Q',
      'VDAYUS@KAU.Q',
      'VDAYJP@KAU.Q',
      'VDAYCAN@KAU.Q',
      'VDAYRES@KAU.Q',
      'VLOS@KAU.Q',
      'VLOSUS@KAU.Q',
      'VLOSJP@KAU.Q',
      'VLOSCAN@KAU.Q',
      'VLOSRES@KAU.Q',
      'VEXP@KAU.Q',
      'VEXPUS@KAU.Q',
      'VEXPJP@KAU.Q',
      'VEXPCAN@KAU.Q',
      'VEXPOT@KAU.Q',
      'VEXPPD@KAU.Q',
      'VEXPPDUS@KAU.Q',
      'VEXPPDJP@KAU.Q',
      'VEXPPDCAN@KAU.Q',
      'VEXPPDOT@KAU.Q',
      'VEXPPT@KAU.Q',
      'VEXPPTUS@KAU.Q',
      'VEXPPTJP@KAU.Q',
      'VEXPPTCAN@KAU.Q',
      'VEXPPTOT@KAU.Q',
      'VS@KAU.Q',
      'VSDM@KAU.Q',
      'VSIT@KAU.Q',
      'OCUP%@KAU.Q',
      'PRM@KAU.Q',
      'RMRV@KAU.Q',
      'E_LH@KAU.Q',
      'E_AF@KAU.Q',
      'EAE@KAU.Q',
      'EAFFAC@KAU.Q',
      'EAFFD@KAU.Q',
    ]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_hi_q
    @series_to_chart = [
      'VIS@HI.Q',
      'VISUS@HI.Q',
      'VISJP@HI.Q',
      'VISCAN@HI.Q',
      'VISRES@HI.Q',
      'VDAY@HI.Q',
      'VDAYUS@HI.Q',
      'VDAYJP@HI.Q',
      'VDAYCAN@HI.Q',
      'VDAYRES@HI.Q',
      'VLOS@HI.Q',
      'VLOSUS@HI.Q',
      'VLOSJP@HI.Q',
      'VLOSCAN@HI.Q',
      'VLOSRES@HI.Q',
      'VEXP@HI.Q',
      'VEXPUS@HI.Q',
      'VEXPJP@HI.Q',
      'VEXPCAN@HI.Q',
      'VEXPOT@HI.Q',
      'VEXPPD@HI.Q',
      'VEXPPDUS@HI.Q',
      'VEXPPDJP@HI.Q',
      'VEXPPDCAN@HI.Q',
      'VEXPPDOT@HI.Q',
      'VEXPPT@HI.Q',
      'VEXPPTUS@HI.Q',
      'VEXPPTJP@HI.Q',
      'VEXPPTCAN@HI.Q',
      'VEXPPTOT@HI.Q',
      'VS@HI.Q',
      'VSDM@HI.Q',
      'VSIT@HI.Q',
      'OCUP%@HI.Q',
      'PRM@HI.Q',
      'RMRV@HI.Q',
      'E_LH@HI.Q',
      'E_AF@HI.Q',
      'EAE@HI.Q',
      'EAFFAC@HI.Q',
      'EAFFD@HI.Q',
    ]
    dates = set_dates_q(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end

  def visitor_mau_a
    @series_to_chart = [
      'VIS@MAU.A',
      'VISUS@MAU.A',
      'VISJP@MAU.A',
      'VISCAN@MAU.A',
      'VISRES@MAU.A',
      'VDAY@MAU.A',
      'VDAYUS@MAU.A',
      'VDAYJP@MAU.A',
      'VDAYCAN@MAU.A',
      'VDAYRES@MAU.A',
      'VLOS@MAU.A',
      'VLOSUS@MAU.A',
      'VLOSJP@MAU.A',
      'VLOSCAN@MAU.A',
      'VLOSRES@MAU.A',
      'VEXP@MAU.A',
      'VEXPUS@MAU.A',
      'VEXPJP@MAU.A',
      'VEXPCAN@MAU.A',
      'VEXPOT@MAU.A',
      'VEXPPD@MAU.A',
      'VEXPPDUS@MAU.A',
      'VEXPPDJP@MAU.A',
      'VEXPPDCAN@MAU.A',
      'VEXPPDOT@MAU.A',
      'VEXPPT@MAU.A',
      'VEXPPTUS@MAU.A',
      'VEXPPTJP@MAU.A',
      'VEXPPTCAN@MAU.A',
      'VEXPPTOT@MAU.A',
      'VS@MAU.A',
      'VSDM@MAU.A',
      'VSIT@MAU.A',
      'OCUP%@MAU.A',
      'PRM@MAU.A',
      'RMRV@MAU.A',
      'E_LH@MAU.A',
      'E_AF@MAU.A',
      'EAE@MAU.A',
      'EAFFAC@MAU.A',
      'EAFFD@MAU.A',
    ]
    dates = set_dates_a(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_hon_a
    @series_to_chart = [
      'VIS@HON.A',
      'VISUS@HON.A',
      'VISJP@HON.A',
      'VISCAN@HON.A',
      'VISRES@HON.A',
      'VDAY@HON.A',
      'VDAYUS@HON.A',
      'VDAYJP@HON.A',
      'VDAYCAN@HON.A',
      'VDAYRES@HON.A',
      'VLOS@HON.A',
      'VLOSUS@HON.A',
      'VLOSJP@HON.A',
      'VLOSCAN@HON.A',
      'VLOSRES@HON.A',
      'VEXP@HON.A',
      'VEXPUS@HON.A',
      'VEXPJP@HON.A',
      'VEXPCAN@HON.A',
      'VEXPOT@HON.A',
      'VEXPPD@HON.A',
      'VEXPPDUS@HON.A',
      'VEXPPDJP@HON.A',
      'VEXPPDCAN@HON.A',
      'VEXPPDOT@HON.A',
      'VEXPPT@HON.A',
      'VEXPPTUS@HON.A',
      'VEXPPTJP@HON.A',
      'VEXPPTCAN@HON.A',
      'VEXPPTOT@HON.A',
      'VS@HON.A',
      'VSDM@HON.A',
      'VSIT@HON.A',
      'OCUP%@HON.A',
      'PRM@HON.A',
      'RMRV@HON.A',
      'E_LH@HON.A',
      'E_AF@HON.A',
      'EAE@HON.A',
      'EAFFAC@HON.A',
      'EAFFD@HON.A',
    ]
    dates = set_dates_a(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_haw_a
    @series_to_chart = [
      'VIS@HAW.A',
      'VISUS@HAW.A',
      'VISJP@HAW.A',
      'VISCAN@HAW.A',
      'VISRES@HAW.A',
      'VDAY@HAW.A',
      'VDAYUS@HAW.A',
      'VDAYJP@HAW.A',
      'VDAYCAN@HAW.A',
      'VDAYRES@HAW.A',
      'VLOS@HAW.A',
      'VLOSUS@HAW.A',
      'VLOSJP@HAW.A',
      'VLOSCAN@HAW.A',
      'VLOSRES@HAW.A',
      'VEXP@HAW.A',
      'VEXPUS@HAW.A',
      'VEXPJP@HAW.A',
      'VEXPCAN@HAW.A',
      'VEXPOT@HAW.A',
      'VEXPPD@HAW.A',
      'VEXPPDUS@HAW.A',
      'VEXPPDJP@HAW.A',
      'VEXPPDCAN@HAW.A',
      'VEXPPDOT@HAW.A',
      'VEXPPT@HAW.A',
      'VEXPPTUS@HAW.A',
      'VEXPPTJP@HAW.A',
      'VEXPPTCAN@HAW.A',
      'VEXPPTOT@HAW.A',
      'VS@HAW.A',
      'VSDM@HAW.A',
      'VSIT@HAW.A',
      'OCUP%@HAW.A',
      'PRM@HAW.A',
      'RMRV@HAW.A',
      'E_LH@HAW.A',
      'E_AF@HAW.A',
      'EAE@HAW.A',
      'EAFFAC@HAW.A',
      'EAFFD@HAW.A',
    ]
    dates = set_dates_a(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end
  
  def visitor_kau_a
    @series_to_chart = [
      'VIS@KAU.A',
      'VISUS@KAU.A',
      'VISJP@KAU.A',
      'VISCAN@KAU.A',
      'VISRES@KAU.A',
      'VDAY@KAU.A',
      'VDAYUS@KAU.A',
      'VDAYJP@KAU.A',
      'VDAYCAN@KAU.A',
      'VDAYRES@KAU.A',
      'VLOS@KAU.A',
      'VLOSUS@KAU.A',
      'VLOSJP@KAU.A',
      'VLOSCAN@KAU.A',
      'VLOSRES@KAU.A',
      'VEXP@KAU.A',
      'VEXPUS@KAU.A',
      'VEXPJP@KAU.A',
      'VEXPCAN@KAU.A',
      'VEXPOT@KAU.A',
      'VEXPPD@KAU.A',
      'VEXPPDUS@KAU.A',
      'VEXPPDJP@KAU.A',
      'VEXPPDCAN@KAU.A',
      'VEXPPDOT@KAU.A',
      'VEXPPT@KAU.A',
      'VEXPPTUS@KAU.A',
      'VEXPPTJP@KAU.A',
      'VEXPPTCAN@KAU.A',
      'VEXPPTOT@KAU.A',
      'VS@KAU.A',
      'VSDM@KAU.A',
      'VSIT@KAU.A',
      'OCUP%@KAU.A',
      'PRM@KAU.A',
      'RMRV@KAU.A',
      'E_LH@KAU.A',
      'E_AF@KAU.A',
      'EAE@KAU.A',
      'EAFFAC@KAU.A',
      'EAFFD@KAU.A',
    ]
    dates = set_dates_a(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end

  def visitor_hi_a
    @series_to_chart = [
      'VIS@HI.A',
      'VISUS@HI.A',
      'VISJP@HI.A',
      'VISCAN@HI.A',
      'VISRES@HI.A',
      'VDAY@HI.A',
      'VDAYUS@HI.A',
      'VDAYJP@HI.A',
      'VDAYCAN@HI.A',
      'VDAYRES@HI.A',
      'VLOS@HI.A',
      'VLOSUS@HI.A',
      'VLOSJP@HI.A',
      'VLOSCAN@HI.A',
      'VLOSRES@HI.A',
      'VEXP@HI.A',
      'VEXPUS@HI.A',
      'VEXPJP@HI.A',
      'VEXPCAN@HI.A',
      'VEXPOT@HI.A',
      'VEXPPD@HI.A',
      'VEXPPDUS@HI.A',
      'VEXPPDJP@HI.A',
      'VEXPPDCAN@HI.A',
      'VEXPPDOT@HI.A',
      'VEXPPT@HI.A',
      'VEXPPTUS@HI.A',
      'VEXPPTJP@HI.A',
      'VEXPPTCAN@HI.A',
      'VEXPPTOT@HI.A',
      'VS@HI.A',
      'VSDM@HI.A',
      'VSIT@HI.A',
      'OCUP%@HI.A',
      'PRM@HI.A',
      'RMRV@HI.A',
      'E_LH@HI.A',
      'E_AF@HI.A',
      'EAE@HI.A',
      'EAFFAC@HI.A',
      'EAFFD@HI.A',
    ]
    dates = set_dates_a(params)
    @start_date = dates[:start_date]
    @end_date = dates[:end_date]
    render "tableview"
  end

  def prudential_list_q
    @series_to_chart = [
      'KRSGFNS@HON.Q',
      'PMKRSGFNS@HON.Q',
      'LRSGFNS@HON.Q',
      'DOMSGFNS@HON.Q',
      'LRSGFNS@HON.Q',
      'KRCONNS@HON.Q',
      'PMKRCONNS@HON.Q',
      'LRCONNS@HON.Q',
      'DOMCONNS@HON.Q',
      'LRCONNS@HON.Q',
      'KRSGFNS@MAU.Q',
      'PMKRSGFNS@MAU.Q',
      'LRSGFNS@MAU.Q',
      'DOMSGFNS@MAU.Q',
      'LRSGFNS@MAU.Q',
      'KRCONNS@MAU.Q',
      'PMKRCONNS@MAU.Q',
      'LRCONNS@MAU.Q',
      'DOMCONNS@MAU.Q',
      'LRCONNS@MAU.Q',
      'KRSGFNS@HAW.Q',
      'PMKRSGFNS@HAW.Q',
      'LRSGFNS@HAW.Q',
      'DOMSGFNS@HAW.Q',
      'LRSGFNS@HAW.Q',
      'KRCONNS@HAW.Q',
      'PMKRCONNS@HAW.Q',
      'LRCONNS@HAW.Q',
      'DOMCONNS@HAW.Q',
      'LRCONNS@HAW.Q',
      'KRSGFNS@KAU.Q',
      'PMKRSGFNS@KAU.Q',
      'LRSGFNS@KAU.Q',
      'DOMSGFNS@KAU.Q',
      'LRSGFNS@KAU.Q',
      'KRCONNS@KAU.Q',
      'PMKRCONNS@KAU.Q',
      'LRCONNS@KAU.Q',
      'DOMCONNS@KAU.Q',
      'LRCONNS@KAU.Q'
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

  def set_dates_a(params)
    if params[:num_years].nil?
      current_year = Time.now.to_date.year
      start_date = "#{current_year-10}-01-01"
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

