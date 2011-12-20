class IntegerPatternProcessor
  def initialize(integer_pattern)
    @integer_pattern = integer_pattern
  end

  def compute(index)
    return Integer(@integer_pattern)
  rescue
    p = @integer_pattern.split ":"
    return pos_by_increment(p[1].to_i, p[2].to_i, index) if p[0] == "increment"
    return pos_by_repeating_number_x_times(p[1].to_i, p[2].to_i, p[3].to_i, index) if p[0] == "block"
    return pos_by_repeating_numbers(p[1].to_i, p[2].to_i, index) if p[0] == "repeat"
    return pos_by_repeating_numbers_with_step(p[1].to_i, p[2].to_i, p[3].to_i, index) if p[0] == "repeat_with_step"  
  end

  def pos_by_increment(start,step,index)
    start + (step * index)
  end

  def pos_by_repeating_numbers_with_step(first, last, step, index)
    range = (last-first)/step+1
    (index % range)*step + first
  end

  def pos_by_repeating_numbers(first, last, index)
    range = last-first+1
    (index % range) + first
  end

  def pos_by_repeating_number_x_times(start, step, repeat, index)
    start + (index/repeat).truncate
  end
end