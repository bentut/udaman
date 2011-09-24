#apdfs.each do |pdf|
#  pdf.series_loaded.each do |series|
#    series_name = series +"."+ Series.code_from_frequency(pdf.frequency)
#    a_missing.push series_name if (Series.get(series_name)).nil?
#  end
#end
#
#a_missing.each do |series|
#  m_series = Series.get series.gsub(".A",".M")
#  m_to_a.push m_series.name unless m_series.nil?
#end
#
#apdfs = PrognozDataFile.all :conditions => {:frequency => :annual}
#
#
#qpdfs = PrognozDataFile.all :conditions => {:frequency => :quarterly}
#q_missing = []
#qpdfs.each do |pdf|
#pdf.series_loaded.each do |series|
#series_name = series +"."+ Series.code_from_frequency(pdf.frequency)
#q_missing.push series_name if (Series.get(series_name)).nil?
#end
#end
#
#a_missing.each do |series|
#m_series = Series.get series.gsub(".Q",".M")
#puts "searching for match for #{series.gsub(".Q",".M")}:"
#puts m_series.name unless m_series.nil?
#m_to_a.push m_series.name unless m_series.nil?
#end
#


