class StringWithDatePatternProcessor
  def initialize(string_format)
    @string_format = string_format
  end

  def compute(date_string)
    subbed_path = @string_format
    subbed_path = @string_format.gsub("UHEROwork", "UHEROwork-1") if ENV["JON"] == "true"
  #  return subbed_path if date_string.nil?
    return date_string.to_date.strftime(@string_format) unless subbed_path.index("%").nil?
    return subbed_path
  end
end