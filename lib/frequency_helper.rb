module FrequencyHelper
  def code_from_frequency(frequency)
    return 'A' if frequency == :year || frequency == "year" || frequency == :annual || frequency == "annual"
    return 'Q' if frequency == :quarter || frequency == "quarter"
    return 'M' if frequency == :month || frequency == "month"
    return 'S' if frequency == :semi || frequency == "semi" || frequency == "semi-annually"
    return 'W' if frequency == :week || frequency == "week" || frequency == "weekly"
    return 'D' if frequency == :day || frequency == "day" || frequency == "daily"
    return ""
  end
  
  def frequency_from_code(code)
    return :year if code == 'A' || code =="a"
    return :quarter if code == 'Q' || code =="q"
    return :month if code == 'M' || code == "m"
    return :semi if code == 'S' || code == "s"
    return :week if code == 'W' || code == "w"
    return :day if code == 'D' || code == "d"
    return nil
  end
end