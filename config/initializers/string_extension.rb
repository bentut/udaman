class String
  def ts
    return Series.get self
  end
  
  def tsn
    return Series.get_or_new self
  end
  
  def ts=(series)
    Series.store self, series
  end
  
  def ts_eval=(eval_statement)
#    begin
#      t = Time.now
      # new_series = eval eval_statement
      # Series.store self, new_series, new_series.name, eval_statement
      Series.eval self, eval_statement
#      puts "#{"%.2f" % (Time.now - t)} | #{new_series.data.count} | #{self} | #{eval_statement}"
#    rescue Exception
    #   puts "ERROR | #{self} | #{eval_statement}"
    # end
  end
    
  def ts_append(series)
    Series.store self, series
  end

  def ts_append_eval(eval_statement)
    self.ts_eval= eval_statement
    # t = Time.now
    # new_series = eval eval_statement
    # Series.store self, new_series, new_series.name, eval_statement
    # puts "#{"%.2f" % (Time.now - t)} | #{new_series.data.count} | #{self} | #{eval_statement}"
  end
  
  def pdf
    return PrognozDataFile.all(:filename => /Data_#{self}.xls$/)[0]
  end
  
  def time
    t = Time.now
    result = eval self
    puts "operation took #{Time.now - t}"
    return result
  end
  
end