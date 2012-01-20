module SeriesHelper
  
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
  
  def aremos_color(val, aremos_val)
    diff = (val - aremos_val).abs
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
