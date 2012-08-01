module DataListsHelper
  require 'csv'

  def csv_helper
    CSV.generate do |csv| 
      series_data = @data_list.series_data
      sorted_names = series_data.keys.sort
      dates_array = @data_list.data_dates
       
      csv << [""] + sorted_names
      dates_array.each do |date|
        csv << [date] + sorted_names.map {|series_name| series_data[series_name][date]}
      end
    end
  end
  
  def js_data_raw
    series_data = @data_list.series_data
    sorted_names = series_data.keys.sort
    dates_array = @data_list.data_dates
    series_data_arrays = {}
    sorted_names.each {|s| series_data_arrays[s] = dates_array.map {|date| series_data[s][date].to_s} }
    rs = ""
    rs += "{\n"
    rs += "\"dates\" : [\"#{dates_array.join("\", \"")}\"],\n"
    rs += "\"data\" : {\n"
    sorted_names.each {|s| rs += "\""+ s + "\" : [" + series_data_arrays[s].join(", ") + "],\n"}
    rs += "}\n"
    rs += "}\n"
    rs
  end
  
  def google_charts_data_table
    series_data = @data_list.series_data
    sorted_names = series_data.keys.sort
    dates_array = @data_list.data_dates
    series_data_arrays = {}
    sorted_names.each {|s| series_data_arrays[s] = dates_array.map {|date| series_data[s][date].to_s} }
    rs = "data = new google.visualization.DataTable();\n"
    rs += "data.addColumn('string', 'date');\ndata.addColumn('number','"
    rs += sorted_names.join("');\n data.addColumn('number','")
    
    rs += "');\ndata.addRows(["
    dates_array.each {|date| rs += "['"+ date +"'," + sorted_names.map {|s| series_data[s][date].nil? ? 0 : series_data[s][date] }.join(", ") +"],\n"}
    rs += "]);\n"
    rs
  end

  def dl_linked_version(description)
    return "" if description.nil?
    new_words = []
    description.split(" ").each do |word|
      #new_word = word.index('@').nil? ? word : link_to(word, {:action => 'show', :id => word.ts.id})
      new_word = word
      begin
        new_word = (word.index('@').nil? or word.split(".")[-1].length > 1) ? word : link_to(word, :controller => 'series', :action => 'show', :id => word.ts.id) 
      rescue Exception
        new_word = word
      end
      new_words.push new_word
    end
    return new_words.join(" ")
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