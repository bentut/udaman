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
    #begin
      Series.eval self, eval_statement
    # rescue Exception
    #    puts "ERROR | #{self} | #{eval_statement}"
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
  
  #needs some modifications to overwrite... do vintages, etc, but this is the basics
  def unzip
    file = self
    #destination = "/" + self.split("/")[1..-2].join("/") + "/"
    destination = self + "_extracted_files/"
    Zip::ZipFile.open(file) { |zip_file|
      zip_file.each { |f|
        f_path=File.join(destination, f.name)
        #puts f_path
        FileUtils.mkdir_p(File.dirname(f_path))
        FileUtils.rm f_path if File.exist?(f_path)
        zip_file.extract(f, f_path) #unless File.exist?(f_path)
      }
    }
  end
  
end

class Array
  def cell(row,col)
    self[row-1][col-1]
  end
  
  def last_row
    self.length
  end
  
  def last_column
    self[0].length
  end
end