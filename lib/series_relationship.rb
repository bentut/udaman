module SeriesRelationship
  def get_ns_series
    ns_series_name = name.sub("@","NS@")
    Series.get ns_series_name
  end
  
  def current_data_points
    self.data_points.where(:current => true).all
  end
  
  #does this return ascending or descending
  #pretty sure it's ascending... [0] = low. Not sure if this is the desired behavior
  #probably something to watch out for. but might be locked into some of the front end
  #stuff
  
  def data_sources_by_last_run
    data_sources.sort_by(&:last_run)
  end

  def clean_data_sources
    results = self.prognoz_data_results
    sources_in_use = {}
    
    results[:data_matches].each do |data_match|
      sources_in_use[data_match[1][:source]] ||= 1
    end
    
    #puts sources_in_use.count
    self.data_sources.each do |ds|
      if sources_in_use[ds.id].nil?
        #puts "deleting #{self.name}: #{ds.id} : #{ds.description}"
        self.data_sources.delete ds.id
      end
    end
    
    self.data_sources.count
  end
  
  def Series.update_sources_in_use
    s = Series.all
    s.each do |series|
      series.clean_data_sources if series.data_sources.count > 1
    end
    return 1
  end
      
  def open_dependencies(refreshed_list)
    od = []
    self.new_dependencies.each do |dep|
      if refreshed_list.index(dep).nil?
        od.push(dep)
      end
    end
    return od
  end
  
  def new_dependents
    results = []
    DataSource.all(:conditions => {:description => /#{self.name}/}).each do |ds|
      #puts ds.description
      results.push Series.find(ds.series_id).name
    end
    return results.uniq
  end
  
  def new_dependencies
    results = []
    self.data_sources.each do |ds|
      results |= ds.dependencies 
    end
    results
  end
  
  def Series.print_multi_sources
    s = Series.all
    s.each do |series|
      puts "#{series.name}: #{series.data_sources.count}" if series.data_sources.count > 1
    end
    return 1
  end
  
  def print_source_eval_statements
    self.data_sources_by_last_run.each do |ds|
      ds.print_eval_statement
    end
    return 0
  end
end