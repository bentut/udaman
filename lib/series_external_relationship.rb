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
    prognoz_data_file = PrognozDataFile.find prognoz_data_file_id
    raise PrognozDataFindException if prognoz_data_file.nil?
    prognoz_data_file.output_series ||= {}
    prognoz_data_file.output_series[self.name] = multiplier
    prognoz_data_file.save
    self.update_attributes(:mult => multiplier)
  end
  
  def toggle_mult
    self.mult ||= 1
    return set_output_series(1000) if self.mult == 1
    return set_output_series(10) if self.mult == 1000
    return set_output_series(1) if self.mult == 10
  end
end