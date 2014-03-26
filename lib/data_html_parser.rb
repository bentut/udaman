class DataHtmlParser

  def get_fred_series(code)
    api_key = '1030292ef115ba08c1778a606eb7a6cc'
    @url = "http://api.stlouisfed.org/fred/series/observations?series_id=#{code}&api_key=#{api_key}"
    @doc = self.download
    return self.get_fred_data
  end
  
  def get_fred_data
    data_hash ||= {}
    @doc.css('observation').each do |obs|
      data_hash[obs[:date]]= obs[:value].to_f unless obs[:value] == "."
    end
    data_hash
  end
  
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

  # working Y@HI.A query
  # http://www.bea.gov/api/data/?&UserID=66533E32-0B70-4EF6-B367-05662C3B7CA8&method=GetData&datasetname=RegionalData&KeyCode=TPI_SI&GeoFIPS=15000&ResultFormat=JSON&
  # NIPA Test
  # http://www.bea.gov/api/data/?&UserID=66533E32-0B70-4EF6-B367-05662C3B7CA8&method=GetData&datasetname=NIPA&TableID=6&Frequency=A&Year=X&GeoFIPS=15001&ResultFormat=JSON&
  def get_bea_series(code, region)
    api_key = "66533E32-0B70-4EF6-B367-05662C3B7CA8"
    fips = {"HI" => "15000", "HON" => "15003", "HAW" => "15001", "MAU" => "15009", "KAU" => "15007", "US" => "00000", "CA" => "06000"}[region]
    @url = "http://www.bea.gov/api/data/?&UserID=#{api_key}&method=GetData&datasetname=RegionalData&KeyCode=#{code}&GeoFIPS=#{fips}&ResultFormat=JSON&"
    @doc = self.download
    new_data = {}
    bea_data = JSON.parse self.content
    bea_data["BEAAPI"]["Results"]["Data"].each do |d| 
      time_period = d["TimePeriod"]
      new_data[ get_date(time_period[0..3], time_period[4..-1]) ] = d["DataValue"].to_f unless d["DataValue"].nil?
    end
    return new_data
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
    return "#{year_string}-07-01" if other_string == "S02"
    return "#{year_string}-01-01" if other_string == "Q1"
    return "#{year_string}-04-01" if other_string == "Q2"
    return "#{year_string}-07-01" if other_string == "Q3"
    return "#{year_string}-10-01" if other_string == "Q4"
    return "#{year_string}-01-01" if other_string == ""
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
