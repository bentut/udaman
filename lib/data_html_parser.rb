class DataHtmlParser

  def get_bls_series(code, frequency = nil)
    @code = code
    @url = 'http://data.bls.gov/pdq/SurveyOutputServlet'
    @post_parameters = {
      'data_tool'=>'srgate',
      'delimeter'=>'tab',
      'initial_request'=>'false',
      'output_format'=>'text',
      'output_type'=>'column',
      'periods_option'=>'all_periods',
      'reformat'=>'true',
      'series_id'=> code,
      'years_option'=>'all_years'
    }
    @doc = self.download
    frequency = self.data.keys[0] if frequency.nil?
    return self.data[frequency]
  end
  
  def doc
    return @doc
  end
  
  def content
    @content
  end
  
  def save_content(save_path)
    open(save_path, "wb") { |file| file.write @content }
  end
  
  def bls_text
    #puts @doc.css("pre").text
    @doc.css("pre").text
  end
  
  def get_data
    @data_hash ||= {}
    data_lines = bls_text.split("\n")
    data_lines.each do |dl|
      next unless dl.starts_with?(@code)
      cols = dl.split(",")
      freq = get_freq(cols[2])
      date_string = get_date(cols[1], cols[2])
      @data_hash[freq] ||= {}
      @data_hash[freq][date_string] = cols[3].to_f
    end
    @data_hash
  end
  
  def data
    @data_hash ||= get_data
  end
  
  def get_freq(other_string)
    return "A" if other_string == "M13"
    return "M" if other_string[0] == "M"
    return "S" if other_string[0] == "S"
    return "Q" if other_string[0] == "Q"
  end
  
  def get_date(year_string, other_string)
    return "#{year_string}-01-01" if other_string == "M13"
    return "#{year_string}-#{other_string[1..2]}-01" unless ["M01","M02","M03","M04","M05","M06","M07","M08","M09","M10","M11","M12"].index(other_string).nil?
    return "#{year_string}-01-01" if other_string == "S01"
    return "#{year_string}-06-01" if other_string == "S02"
  end
  
  def download
    begin
      client = HTTPClient.new
      if @post_parameters.nil? or @post_parameters.length == 0
        resp = client.get(@url)
      else
        resp = client.post(@url, @post_parameters) 
      end
      @content = resp.content
      return Nokogiri::HTML(resp.content)
    rescue Exception
      return "Something went wrong with download"
    end
  end
  
  
end
