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
  
  def to_ascii_iconv
     converter = Iconv.new('ASCII//IGNORE//TRANSLIT', 'UTF-8')
     converter.iconv(self).unpack('U*').select{ |cp| cp < 127 }.pack('U*')
  end
  
  def no_okina
    #uses generic apostrophe... assuming to_ascii_iconv above
    self.gsub("'","")
  end
  

end

class Array
  
  def cell(row,col)
    return nil if self[row-1].nil?
    self[row-1][col-1]
  end
  
  def last_row
    self.length
  end
  
  def last_column
    self[0].length
  end
end

class Float
  
  def to_sci
    ("%E" % self).to_f
  end
  
  def aremos_trunc
    return self if self == 0
    scale = 10**((Math.log10(self.abs)+1-7).floor)
    return (scale * (self / scale).truncate).to_f.round(3)
  end
  
  def aremos_round
    return self if self == 0
    scale = 10**((Math.log10(self.abs)+1).floor)
    return ((self / scale).single_precision.round(7) * scale).to_f.round(3)
  end
  
  def aremos_single_precision_round
    return self if self == 0
    scale = 10**((Math.log10(self.abs)+1).floor)
    return ((self.single_precision / scale).single_precision.round(7).single_precision * scale).to_f.single_precision.round(3)
  end
  
  def aremos_store_convert
    return self if self == 0
    scale = 10**((Math.log10(self.abs)+1).floor)
    return ((self / scale).round(8) * scale).to_f.round(3)
  end
  
  def single_precision
    [self].pack("f").unpack("f")[0]
  end
  
  def sig_digits(num)
    return self if self == 0
    scale = 10**((Math.log10(self.abs)+1).floor)
    return ((self / scale).round(num) * scale).to_f
  end
end
