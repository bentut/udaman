module SeriesComparison
  def match_dates_with(data_to_compare)
    data_non_nil = 0
    self.data.each do |date_string, value|
      return false unless data_to_compare.has_key? date_string or value.nil?
      data_non_nil += 1 unless value.nil?
    end
    compare_non_nil = 0
    data_to_compare.each do |date_string,value|
      compare_non_nil += 1 unless value.nil?
    end
    return compare_non_nil == data_non_nil
  end
  
  def match_data_date(date_string, data_to_compare)
    match_data(self.at(date_string), data_to_compare[date_string])
  end
  
  def round_to_1000(num)
    (((num)*1000).round)/1000.to_f
  end
  
  def match_data(data1, data2)
    begin
      # return true if data1.class == String and (data1.strip == "" and data2.nil?) 
      #       return true if data2.class == String and (data1.nil? and data2.strip == "") 
      return false if data1.class != data2.class unless (data1.class == Float and data2.class == Fixnum) or (data2.class == Float and data1.class == Fixnum)
      return true if data1 == 0.0 and data2 == 0.0
      tolerance_check = (data1 - data2).abs < 0.05 * data1.abs if data1.class == Float
      rounding_check = round_to_1000(data1) == round_to_1000(data2) if data1.class == Float
      return (tolerance_check or rounding_check) if data1.class == Float
      return data1 == data2
    rescue FloatDomainError
      return data1 == data2
    end
  end
  
  def identical_to?(data_to_compare)
    self.mult ||= 1
    self.data.sort.each do |date_string, value|
      # puts "comparing #{date_string} series: #{value.class} other: #{data_to_compare[date_string].class}"
      value = value/self.mult.to_f unless value.nil? or value.class == String
      return false unless match_data(value, data_to_compare[date_string])
    end
    return match_dates_with(data_to_compare)
  end
  
  #test this
  def sufficient_match?(data_to_compare, prognoz = false)
    self.mult ||= 1
    ret_val = true
    self.prognoz_missing = 0
    self.prognoz_diff = 0
    self.data.each do |date_string, value|
      value = value/self.mult.to_f unless value.nil? or value.class == String
      match_result = match_data(value, data_to_compare[date_string]) 
      ret_val = false unless match_result or data_to_compare[date_string].nil?
      self.prognoz_missing += 1 if match_result == false and (value.nil? and !data_to_compare[date_string].nil?) and prognoz
      self.prognoz_diff += (data_to_compare[date_string].to_f - value.to_f).abs if data_to_compare[date_string] != nil and value != nil and prognoz
    end
    self.save if prognoz
    return ret_val
  end
  
  def aremos_match
    self.mult ||= 1
    self.aremos_missing = 0
    self.aremos_diff = 0
    aremos_series = AremosSeries.get self.name
    data_to_compare = aremos_series.nil? ? {} : aremos_series.data 
    self.data.each do |date_string, value|
      value = value/self.mult.to_f unless value.nil? or value.class == String
      #match_result = match_data(value, data_to_compare[date_string]) 
      self.aremos_missing += 1 if match_result == false and (value.nil? and !data_to_compare[date_string].nil?)
      self.aremos_diff += (data_to_compare[date_string].to_f.to_sci - value.to_f.to_sci).abs if data_to_compare[date_string] != nil and value != nil
    end
    self.save
  end
  
  def matches_prognoz?
    sufficient_match? prognoz_output_data, true
    #identical_to? prognoz_output_data
  end
  
  def match_results
    results = {}
    self.mult ||= 1
    self.aremos_missing = 0
    self.aremos_diff = 0
    self.aremos_temp = "ewfe"
    sources = self.data_sources_by_last_run
    prognoz_data_file = PrognozDataFile.find prognoz_data_file_id
    aremos_series = AremosSeries.get self.name
    p_filename = prognoz_data_file.nil? ? "N/A" : prognoz_data_file.filename  
    p_data = prognoz_data_file_id.nil? ? {} : prognoz_data_file.get_data_for(self.name)
    a_data = aremos_series.nil? ? {} : aremos_series.data
    self.data.each do |datestring, value|
      original_value = value
      value = value/self.mult.to_f unless value.nil? or value.class == String
      data_source = ""
      match_result = true
      sources.each { |source| data_source = source if self.match_data(original_value, source.at(datestring)) }
      if a_data != {}
        match_result = self.match_data(value, a_data[datestring]) if a_data != {}
        self.aremos_missing += 1 if match_result == false and (value.nil? and !a_data[datestring].nil?)
        self.aremos_diff += (a_data[datestring].to_f - value.to_f).abs if a_data[datestring] != nil and value != nil
        self.aremos_temp += "#{(a_data[datestring].to_f - value.to_f).abs}," if a_data[datestring] != nil and value != nil
      end
      match_result = match_result and self.match_data(value, p_data[datestring]) if p_data != {}
      results[datestring] = {:database=> value, :prognoz => p_data[datestring], :aremos => a_data[datestring], :match => match_result, :source => data_source.id, :color => data_source.color}
    end
    self.save
    return {:prognoz_filename => p_filename, :data_matches => results}
  end
  
  
  
  
  
  #might want to throw the color designation into this function and just pull it out of here instead of searching later.
  def prognoz_data_results
    sources = self.data_sources_by_last_run
    self.mult ||= 1
    prognoz_data_file = PrognozDataFile.find prognoz_data_file_id
    if prognoz_data_file.nil?
      results = {}
      self.data.each do |datestring, value|
        original_value = value
        data_source = ""
        colors = {}
        sources.each do |source|
          if self.match_data(original_value, source.at(datestring))
            data_source = source.id
            colors[data_source] = source.color if colors[data_source].nil?
          end
        end
        results[datestring] = {:database=> value, :prognoz => "N/A", :match => true, :source => data_source, :color => colors[data_source]} 
      end
      return {:prognoz_filename => "N/A", :data_matches => results}
    else
      if prognoz_output_data.nil?
        self.prognoz_output_data = prognoz_data_file.get_data_for self.name
        self.mult = prognoz_data_file.output_series[self.name]
      end
    
      results = {}
      self.data.each do |datestring, value|
        original_value = value
        value = value/self.mult.to_f unless value.nil? or value.class == String
        data_source = ""
        colors = {}
        sources.each do |source|
          if self.match_data(original_value, source.at(datestring))
            data_source = source.id
            colors[data_source] = source.color if colors[data_source].nil?
          end
        end
        match_result = self.match_data(value, prognoz_output_data[datestring])
        results[datestring] = {:database=> value, :prognoz => prognoz_output_data[datestring], :match => match_result, :source => data_source, :color => colors[data_source]} 
      end
      return {:prognoz_filename => prognoz_data_file.filename, :data_matches => results}
    end
  end
end