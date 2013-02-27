module SeriesRelationship
  def get_ns_series
    ns_series_name = name.sub("@","NS@")
    Series.get ns_series_name
  end
  
  def current_data_points
    self.data_points.where(:current => true).order(:date_string).all
  end
  
  #does this return ascending or descending
  #pretty sure it's ascending... [0] = low. Not sure if this is the desired behavior
  #probably something to watch out for. but might be locked into some of the front end
  #stuff
  
  def data_sources_by_last_run
    data_sources.sort_by(&:last_run)
  end

  def clean_data_sources
    sources_in_use = {}
    
    self.current_data_points.each do |dp|
      sources_in_use[dp.data_source_id] ||= 1
    end
    
    #puts sources_in_use.count
    self.data_sources.each do |ds|
      if sources_in_use[ds.id].nil?
        #puts "deleting #{self.name}: #{ds.id} : #{ds.description}"
        ds.delete
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
    DataSource.all(:conditions => ["description LIKE ?", "%#{self.name.gsub("%", "\\%")}%"]).each do |ds|
#      puts ds.description
      s = Series.find(ds.series_id)
      #puts self.name + " : " +  s.name + " : " + ds.id.to_s
      results.push s.name
      results += s.new_dependents
    end
    return results.uniq
  end
  
  def new_dependencies
    results = []
    self.data_sources.each do |ds|
      results |= ds.dependencies 
    end
    second_order_results = []
    results.each {|s| second_order_results |= s.ts.new_dependencies}
    results |= second_order_results
  end
  
  def first_order_dependencies
    results = []
    self.data_sources.each do |ds|
      results |= ds.dependencies 
    end
    results
  end
  
  def Series.find_first_order_circular
    circular_series = []
    Series.all.each do |series|
      #puts series.name
      fod = series.first_order_dependencies
      fod.each do |dependent_series|
        begin
          circular_series.push(dependent_series) unless dependent_series.ts.first_order_dependencies.index(series.name).nil?
        rescue
          puts "THIS BROKE"
          puts dependent_series
          puts series.name
          puts series.id
        end
      end
    end

    potential_problem_ds = []
    circular_series.each do|s_name|
      s_name.ts.data_sources.each do |ds|
        potential_problem_ds.push ds
        puts "#{s_name}: #{ds.id} : #{ds.eval}"
      end
    end
    (potential_problem_ds.sort {|a,b| a.id <=> b.id}).each do |ppd|
      puts "#{ppd.id} : #{ppd.eval}"
    end
    circular_series
  end
  
  def Series.print_prioritization_info
    Series.where("aremos_missing = 0 AND ABS(aremos_diff) >= 10").order('ABS(aremos_diff) DESC').each {|s| puts "#{s.id} - #{s.name}: #{s.new_dependents.count} / #{s.new_dependencies.count} : #{s.aremos_diff}" if s.new_dependents.count > 0 }
  end
  
  def Series.print_multi_sources
    s = Series.all
    s.each do |series|
      puts "#{series.name}: #{series.data_sources.count}" if series.data_sources.count > 1
    end
    return 1
  end
  
  def reload_sources
    begin
      puts self.name
      # self.data_sources_by_last_run.each do |ds|
      #   ds.print_eval_statement
      #   ds.reload_source
      # end
      return 0
    rescue Exception
      puts "SOMETHING BROKE -----------------------------------------------"
    end
  end
  
  def print_source_eval_statements
    self.data_sources_by_last_run.each do |ds|
      ds.print_eval_statement
    end
    return 0
  end
  
  
end