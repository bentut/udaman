module PrognozDataFilesHelper

  #color green: #8bd881
  #color red: #feabab 
  def series_table(output_file)    
    return if output_file.series_loaded.nil?
    table_string = "<table>"
    output_file.series_loaded.each do |series_name, data|
      found = series_name.ts
      row_id = found.nil? ? "" : "validate_row_#{found.id}"
      table_string += "<tr id='#{row_id}'>"
      table_string += validated_row(output_file, series_name, found, row_id)
      table_string += "</tr>"
    end
    return table_string + "</table>"
  end
  
  def validated_row(output_file, series_name, found, row_id)
    series_id = found.nil? ? "" : found.id
                    "<td></td>" +
                    "<td>#{link_to series_name, {:controller => 'series', :action => "show", :id => series_id}}</td>"
  end
  
  def short_path(path)
    pathparts = path.split("/")
    return pathparts[-2]+"/"+pathparts[-1] unless pathparts[-2].nil?
    return path
  end
  
end
