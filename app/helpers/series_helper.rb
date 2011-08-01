module SeriesHelper
  # def data_list(data)
  #   html = "<ul id='series_data'>"
  #   data.sort.each do |date,datapoint|
  #     html+="<li>#{date}: #{datapoint}</li>"
  #   end
  #   return html+"</ul>"
  # end
  
  # def data_list(series)
  #   as = AremosSeries.get series.name
  #   html = "<table><tr><th>Date</th><th>AREMOS</th><th></th><th>Values</th></tr>"
  #   series.current_data_points.sort_by(&:date_string).each do |cdp|
  #     a_value = (as.nil? or as.data[cdp.date_string].nil?) ? "-" : as.data[cdp.date_string].round(3) 
  #     a_color = a_value - cdp.value.round(3) == 0 ? "gray" : "red" unless a_value.nil? or a_value.class == String
  #     dp_html = "<div class='datapoint current-datapoint' style='background-color:##{DataSource.find(cdp.data_source_id).color}'>#{"%.3f" % cdp.value}</div>"
  #     series.data_points.where(:current => false, :date_string => cdp.date_string).sort_by(&:created_at).reverse.each do |dp|
  #       dp_html += "<div class='datapoint' style='background-color:##{DataSource.find(dp.data_source_id).color}'>#{"%.3f" % dp.value}</div>"
  #     end
  #     html += "<tr><td>#{cdp.date_string}</td><td><span style='color:#{a_color}'>#{a_value}</span></td><td>#{"H" unless cdp.history.nil?}</td><td><span class='current-datapoint'>#{dp_html}</span></td></tr>"
  #   end
  #   return html + "</table>"
  #   #return "hi"
  # end
  
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
      new_word = word.index('@').nil? ? word : link_to(word, {:action => 'show', :id => word.ts.id}) rescue word
      new_words.push new_word
    end
    return new_words.join(" ")
  end
  
  # def source_list(data_sources, series_id)
  #   html = "<table><tr><th>source&nbsp;date</th><th>description</th></tr>"
  #   data_sources.each do |ds|
  #     eval = ds.eval.nil? ? " " : ds.eval.split(" ").join("&nbsp;")
  #     html+= "<tr style=\"background-color:##{ds.color}\">"
  #     html+="<td>#{ds.last_run.localtime.strftime("%m/%d/%y&nbsp;<span style=\"color:gray\">%H:%M:%S</span>")}"
  #     html+="<br />#{link_to "load", {:controller=> "data_sources", :action => 'source', :id => ds.id}}" unless ds.eval.nil?
  #     html+="&nbsp;|&nbsp;#{link_to "delete", {:controller=> "data_sources", :action => 'delete', :id => ds.id}, :confirm => "Are you sure you want to delete this data soure?"}"
  #     html+="&nbsp<span style=\"color:gray\">(#{ds.runtime.round(2)}s)</span>" unless ds.runtime.nil?
  #     html+="</td>"
  #     html+="<td>#{linked_version(ds.description)}<br />#{eval}</td>"
  #     html+= "</tr>"      
  #   end
  #   return html+"</table>"
  # end
  
  # def get_operations_map(sources, series_name)
  #   colors = ["FFCC99", "CCFFFF", "99CCFF", "CC99FF", "FFFF99", "CCFFCC", "FF99CC", "CCCCFF", "9999FF", "99FFCC"]
  #   html = "<table class=\"operations-table\">"
  #   sources.each do |ds|
  #     html += "<tr>#{render_operations_map ds, "AAAAAA", colors, 0, [series_name]}</tr>" rescue html += "<tr><td>broken but #{ds.description}</td></tr>"
  #   end
  #   html += "</table>"
  # end
  # 
  # #old was source, float time
  # def render_operations_map(source, color, colors, depth, seen)
  #   #to get it back Time.at(1056030443784/1000.0).strftime("%Y-%m-%d %H:%M.%S")
  #   html = "<td style=\"background-color:##{color}\">#{source.description} <br> [#{source.last_run.localtime.strftime("%Y-%m-%d %H:%M:%S")}]</td>"
  #   return html if depth > 6
  #   
  #   components = []
  #   source.description.split(" ").each do |word|
  #     components.push(word) unless word.index('@').nil?
  #   end
  #   
  #   if components.length > 0
  #     html += "<td><table>"
  #     components.each do |series_name|
  #       next unless seen.index(series_name).nil?
  #       seen.push(series_name)
  #       color = colors.shift rescue color = "FFFFFF"
  #       series = series_name.ts
  #       missing = series.prognoz_missing.nil? ? "N/A" : series.prognoz_missing
  #       diff = series.prognoz_diff.nil? ? "N/A" : series.prognoz_diff
  #       html += "<tr>"
  #       html += "<td style=\"background-color:##{color}\">#{link_to series_name, {:action => 'show', :id => series.id}} <br>missing:#{missing}<br>diff:#{diff}</td>"
  #       html += "<td><table>"
  #       series.data_sources_by_last_run.each do |ds|
  #         html += "<tr>#{render_operations_map ds, color, colors, depth + 1, seen}</tr>"
  #       end
  #       html += "</table></td>"
  #       html += "</tr>"
  #     end
  #     html += "</table></td>"
  #   end
  #   
  #   return html
  # end
  
  def validate_data_list(validate_data, mult)
    html = "<table><tr><th></th><th>date</th><th>mult</th><th>database</th><th>prognoz</th><th>match</th></tr>"
    found_colors = {}
    validate_data.sort.each do |date,datapoint|
      style = "style=\"background-color:#feabab\"" unless datapoint[:match]
      html+= "<tr #{style}>"
      html+="<td style=\"background-color:##{datapoint[:color]}\"></td>"
      html+="<td>#{date}</td>"
      html+="<td>#{mult}</td>"
      html+="<td>#{datapoint[:database]}</td>"
      html+="<td>#{datapoint[:prognoz]}</td>"
      html+="<td>#{datapoint[:match]}</td>"
      html+= "</tr>"
    end
    return html+"</table>"
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
