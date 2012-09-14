module SeriesExternalRelationship
  def find_prognoz_data_file
  	#also should rewrite if possible to query by contents of mongodb object
  	pdfs = PrognozDataFile.all
  	pdfs.each do |pdf|
  		return pdf if pdf.series_loaded.include?(self.name) 
  	end
  	return nil
  end
  
   def set_output_series(multiplier)
     self.update_attributes(:mult => multiplier)
   end
  
  def toggle_mult
    self.mult ||= 1
    return set_output_series(1000) if self.mult == 1
    return set_output_series(10) if self.mult == 1000
    return set_output_series(1) if self.mult == 10
  end
  
  def a_diff(value, series_value)
    # diff_trunc = (value - series_value.aremos_trunc).abs  
    # diff_round = (value - series_value.single_precision.aremos_round).abs  
    # diff_sci = (value - series_value.single_precision.to_sci).abs
    # return diff_sci if diff_sci < diff_round and diff_sci < diff_trunc  
    # diff_first = diff_trunc < diff_round ? diff_trunc : diff_round
    # diff_second = diff_first < diff_sci ? diff_first : diff_sci
    
    diff_trunc = (value - series_value.aremos_trunc).abs.round(3)  
    diff_sig_5 = (value.sig_digits(5).round(3) - series_value.sig_digits(5).round(3)).abs
    diff_sig_6 = (value.sig_digits(6).round(3) - series_value.sig_digits(6).round(3)).abs

    diff_first = diff_trunc < diff_sig_5 ? diff_trunc : diff_sig_5
    diff_second = diff_first < diff_sig_6 ? diff_first : diff_sig_6
    
    return diff_second > 0.001 ? diff_second : 0
  end
  #no test or spec for this
  def aremos_comparison(save_series = true)
    begin
      as = AremosSeries.get self.name
      if as.nil?
        #puts "NO MATCH: #{self.name}"
        self.aremos_missing = "-1"
        self.save if save_series
        return {:missing => "No Matching Aremos Series", :diff => "No Matching Aremos Series"}
      end
      missing_keys = (as.data.keys - self.data.keys)
      
      #remove all suppressed values
      missing_keys.delete_if {|key| as.data[key] == 1000000000000000.0}
      
      self.aremos_missing = missing_keys.count
      self.aremos_diff = 0
      #self.units ||= 1
      as.data.each do |datestring, value|
        unless self.data[datestring].nil?
          #have to do all the rounding because it still seems to suffer some precision errors after initial rounding
          diff = a_diff(value, self.units_at(datestring))
          self.aremos_diff +=  diff 
          puts "#{self.name}: #{datestring}: #{value}, #{self.units_at(datestring)} diff:#{diff}" if diff != 0
        end
      end
      self.save if save_series
      #puts "Compared #{self.name}: Missing: #{self.aremos_missing} Diff:#{self.aremos_diff}"
      return {:missing => self.aremos_missing, :diff => self.aremos_diff}
    rescue Exception => e
      puts e.message
      puts "ERROR WITH \"#{self.name}\".ts.aremos_comparison"
    end
  end
  
  
  def aremos_comparison_display_array
    
    results = []
    begin
      as = AremosSeries.get self.name
      if as.nil?
        return []
      end
      
      as.data.each do |datestring, value|
        data = self.data
        unless data[datestring].nil?
          diff = a_diff(value, self.units_at(datestring))
          dp = DataPoint.where(:series_id => self.id, :date_string => datestring, :current=>true)[0]
          source_code = dp.source_type_code
          puts "#{self.name}: #{datestring}: #{value}, #{self.units_at(datestring)} diff:#{diff}" if diff != 0
          results.push(0+source_code) if diff == 0
          results.push(1+source_code) if diff > 0 and diff <= 1.0
          results.push(2+source_code) if diff > 1.0 and diff  <= 10.0
          results.push(3+source_code) if diff > 10.0          
          next #need this. otherwise might add two array elements per diff
        end
        
        if data[datestring].nil? and value == 1000000000000000.0
          results.push(0)
        else
          results.push(-1)
        end
      end
      results
    rescue Exception => e
      puts e.message
      puts "ERROR WITH \"#{self.name}\".ts.aremos_comparison"
    end
    
  end
  
  def data_diff_display_array(comparison_data, digits_to_round)
    results = []
    comparison_data.each do |date_string, value|
      dp = DataPoint.where(:series_id => self.id, :date_string => date_string, :current=>true)[0]
      
      if dp.nil? and !value.nil?
        results.push(-1)
        next
      end

      if (dp.nil? and value.nil?) or dp.is_pseudo_history?
        results.push(0)
        next
      end
      
      source_code = dp.source_type_code
      diff = (units_at(date_string) - value).abs unless data[date_string].nil? or value.nil?
      
      unless diff.nil?
        results.push(0+source_code) if diff < 10**-digits_to_round
        results.push(1+source_code) if diff > 10**-digits_to_round and diff <= 1
        results.push(2+source_code) if diff > 1.0 and diff  <= 10.0
        results.push(3+source_code) if diff > 10.0          
        next
      end
      
      
    end
    results
  end
  
  def data_diff(comparison_data, digits_to_round)
    diff_hash = {}
    comparison_data.each do |date_string, value|
      dp = DataPoint.where(:series_id => self.id, :date_string => date_string, :current=>true)[0] # only used for pseudo_history_check
      diff = units_at(date_string) - value unless data[date_string].nil? or value.nil?
      diff_hash[date_string] = diff if (diff.nil? and !data[date_string].nil?) or (!diff.nil? and diff > 10**-digits_to_round) unless (dp and dp.is_pseudo_history?)
    end
    diff_hash
  end
  
  
  
  def find_units
    begin
      unit_options = [1,10,100,1000]
      lowest_diff = nil
      best_unit = nil
    
      unit_options.each do |u|
        self.units = u
        diff = aremos_comparison[:diff]
        if lowest_diff.nil? or diff.abs < lowest_diff
          lowest_diff = diff.abs
          best_unit = u
        end
      end
    
      puts "#{self.name}: SETTING units = #{best_unit}"
      self.units = best_unit
      self.aremos_comparison  
    rescue Exception
      puts "#{self.name}: SETTING DEFAULT"
      self.update_attributes(:units => 1)
    end
  end
  
end