module SeriesHelper
  
  require 'csv'

  def csv_helper
    CSV.generate do |csv| 
      # series_data = @data_list.series_data
      # sorted_names = series_data.keys.sort
      # dates_array = @data_list.data_dates
      dates = @series.data.keys
      val = @series.data
      lvls = @lvl_chg.data
      yoy = @chg.data
      ytd = @ytd_chg.data
       
      csv << ["Date", "Values", "LVL","YOY", "YTD"]
      # dates_array.each do |date|
      #   csv << [date] + sorted_names.map {|series_name| series_data[series_name][date]}
      # end
      dates.sort.each do |date|
        csv << [date, val[date], lvls[date], yoy[date], ytd[date]]
      end
    end
  end
  
  def google_charts_data_table
    #series_data = @data_list.series_data
    sorted_names = @all_series_to_chart.map {|s| s.name }
    dates_array = []
    @all_series_to_chart.each {|s| dates_array |= s.data.keys}
    dates_array.sort!
    series_data = {}
    @all_series_to_chart.each do |s|
      s_dates = {}
      dates_array.each {|date| s_dates[date] = s.data[date].to_s} 
      series_data[s.name] = s_dates 
    end
    rs = "data = new google.visualization.DataTable();\n"
    rs += "data.addColumn('string', 'date');\ndata.addColumn('number','"
    rs += sorted_names.join("');\n data.addColumn('number','")
    
    rs += "');\ndata.addRows(["
    dates_array.each do |date| 
      rs += "['"+ date +"',"
      # data_points = []
      # sorted_names.each do |s|
      #   push_val = 0
      #   push_val = series_data[s][date] == ""
      #   data_points.push(push_val)
      # end
      #rs += data_points.join(", ") +"],\n"
      rs += sorted_names.map {|s| series_data[s][date] == "" ? "0" : series_data[s][date] }.join(", ") +"],\n"
    end
    rs += "]);\n"
    rs 
  end
  
  def gct_datapoints(series)
  arr = series.data.keys.sort
  html =""
  arr.each do |key|
    html += "['#{key}',#{series.data[key]}]," unless series.data[key].nil?
  end
  #html += "['hi',10.0], ['bye', 30.0],"
  return html.chop
  end
  
  def linked_version(description)
    return "" if description.nil?
    new_words = []
    description.split(" ").each do |word|
      #new_word = word.index('@').nil? ? word : link_to(word, {:action => 'show', :id => word.ts.id})
      new_word = word
      begin
        new_word = (word.index('@').nil? or word.split(".")[-1].length > 1) ? word : link_to(word, {:action => 'show', :id => word.ts.id}) 
      rescue
        new_word = word
      end
      new_words.push new_word
    end
    return new_words.join(" ")
  end
  
#  def aremos_color(val, aremos_val)
  def aremos_color(diff)

#    diff = (val - aremos_val).abs
    mult = 5000
    gray = "99"
    red = (gray.hex + diff * mult).to_i
    green = (gray.hex - diff * mult).to_i
    blue = (gray.hex - diff * mult).to_i
    red = 255 if red > 255
    green = 20 if green < 20 
    blue = 20 if blue < 20
    return "##{red.to_s(16)}#{green.to_s(16)}#{blue.to_s(16)}"
  end
  
  def navigation_by_letter
    html = "<br />"
    "A".upto("Z") do |letter|
      count = Series.all(:conditions => ["name LIKE ?", "#{letter}%"]).count
      #count = Series.where(:name => /^#{letter}/)
      if count > 0
        html += link_to raw("["+letter+"&nbsp;<span class='series_count'>#{count}</span>]"), {:action => 'index', :prefix => letter}
        html += " "
      end
    end
    html
  end
  
  def navigation_by_frequency
    html = ""
    [:month, :quarter, :year].each do |frequency|
      count = Series.where(:frequency => frequency).count
      html += link_to raw(frequency.to_s + "&nbsp;<span class='series_count'>#{count}</span>"), {:action => 'index', :freq => frequency}
      html += "&nbsp;"
    end
    count = Series.count
	  html += link_to raw("all&nbsp;<span class='series_count'>#{count}</span>") , {:action => 'index', :all => 'true'}
		
  end
end


# array2d = []
# array2d.push([""] + sorted_names)
# dates_array.each do |date|
#   array2d.push([date] + sorted_names.map {|series_name| series_data[series_name][date]})
# end
# csv << [""] + sorted_names
# dates_array.each do |date|
#   csv << [date] + sorted_names.map {|series_name| series_data[series_name][date]}
# end