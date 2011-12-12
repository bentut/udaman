def compute_integer_pattern(item, date_string)
  return Integer(item)
rescue
  pattern = item.split ":"
  return Pattern.pos_by_increment(pattern[1].to_i, pattern[2].to_i, compute_index_for_date(date_string)) if pattern[0] == "increment"
  return Pattern.pos_by_repeating_number_x_times(pattern[1].to_i, pattern[2].to_i, pattern[3].to_i, compute_index_for_date(date_string)) if pattern[0] == "block"
  return Pattern.pos_by_repeating_numbers(pattern[1].to_i, pattern[2].to_i, compute_index_for_date(date_string)) if pattern[0] == "repeat"
  return Pattern.pos_by_repeating_numbers_with_step(pattern[1].to_i, pattern[2].to_i, pattern[3].to_i, compute_index_for_date(date_string)) if pattern[0] == "repeat_with_step"
end

def Pattern.pos_by_increment(start,step,index)
  start + (step * index)
end

def Pattern.pos_by_repeating_numbers_with_step(first, last, step, index)
  range = (last-first)/step+1
  (index % range)*step + first
end

def Pattern.pos_by_repeating_numbers(first, last, index)
  range = last-first+1
  (index % range) + first
end

def Pattern.pos_by_repeating_number_x_times(start, step, repeat, index)
  start + (index/repeat).truncate
end
