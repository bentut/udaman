class Hash
  def series_merge(other_hash)
    h = {}
    self.merge(other_hash).keys.each do |key|
      h[key] = other_hash[key] || self[key]
    end
    return h
  end
  
  def sources_merge(single_source_hash)
    self.each do |key, value|
      self.delete key if value["description"] == single_source_hash[single_source_hash.keys[0]][:description]
    end
    return self.merge single_source_hash
  end
  
  def cs(series_name)
    Series.create_from_data_hash(series_name, self)
  end
  
  def ns(series_name)
    Series.new_from_data_hash(series_name, self)
  end
end