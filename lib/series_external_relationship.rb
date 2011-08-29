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
  
  #no test or spec for this
  def aremos_comparison
    begin
      as = AremosSeries.get self.name
      if as.nil?
        puts "NO MATCH: #{self.name}"
        self.aremos_missing = "-1"
        self.save
        return {:missing => "No Matching Aremos Series", :diff => "No Matching Aremos Series"}
      end
      self.aremos_missing = (as.data.keys - self.data.keys).count
      self.aremos_diff = 0
      #self.units ||= 1
      as.data.each do |datestring, value|
        #puts self.units
        self.aremos_diff += (value - self.units_at(datestring)) unless self.data[datestring].nil?
      end
      self.save
      puts "Compared #{self.name}: Missing: #{self.aremos_missing} Diff:#{self.aremos_diff}"
      return {:missing => self.aremos_missing, :diff => self.aremos_diff}
    rescue Exception
      puts "ERROR WITH \"#{self.name}\".ts.aremos_comparison"
    end
  end
  
  def find_units
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
    
    self.units = best_unit
    self.aremos_comparison  
  end
  
end