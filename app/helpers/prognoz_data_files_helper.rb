module PrognozDataFilesHelper

  #color green: #8bd881
  #color red: #feabab 
  def series_table(output_file)    
    return if output_file.series_loaded.nil?
    table_string = "<table>"
    output_file.series_loaded.each do |series_name|
      found = series_name.ts
      row_id = found.nil? ? "" : "validate_row_#{found.id}"
      table_string += "<tr id='#{row_id}'>"
      table_string += validated_row(output_file, series_name, found, row_id)
      table_string += "</tr>"
    end
    return table_string + "</table>"
  end
  
  def validated_row(output_file, series_name, found, row_id)
    #update_ss = found ? output_file.series_covered[series_name][:update_spreadsheet] : ""
    #valid = found ? output_file.series_validated.include?(series_name) : nil
    multiplier = found.nil? ? "" : found.multiplier 
    #style = "style=\"background-color:#feabab\"" unless valid and found
    #validate_link = found ? "<a href='/series/validate/#{output_file.series_covered[series_name][:id]}'>diff</a>" : ""
    multiplier_link = found.nil? ?  "" : link_to_remote(multiplier, :update => row_id, :url => {:controller => 'series', :action => 'toggle_multiplier', :id => found.id}) 
    series_id = found.nil? ? "" : found.id
                    "<td #{style}>#{multiplier_link}</td>" +
                    "<td #{style}>#{link_to series_name, {:controller => 'series', :action => "show", :id => series_id}}</td>"
                    #{}"<td #{style}>#{output_file.series_covered[series_name][:missing]}</td>" +
                    #{}"<td #{style}>#{output_file.series_covered[series_name][:diff].round(2)}</td>" +
                    #"<td #{style}>#{validate_link}</td>" +
                    #{}"<td #{style}>#{update_ss}</td>"
  end
  
  def short_path(path)
    pathparts = path.split("/")
    return pathparts[-2]+"/"+pathparts[-1] unless pathparts[-2].nil?
    return path
  end
  
end
