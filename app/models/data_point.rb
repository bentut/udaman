class DataPoint < ActiveRecord::Base
  belongs_to :series
  belongs_to :data_source
  
  def upd(value, data_source)
    return self                                     if trying_to_replace_current_value_with_nil?(value) #scen 0
    return update_timestamp                         if same_as_current_data_point?(value, data_source) #scen 1
    prior_dp = restore_prior_dp(value, data_source) if value_or_data_source_has_changed?(value, data_source) #scen 2
    return prior_dp                                 unless prior_dp.nil?
    return create_new_dp(value, data_source)         #scen 3
  end
  
  def value_or_data_source_has_changed?(value, data_source)
    !same_value_as?(value) or self.data_source_id != data_source.id
  end
  
  def same_as_current_data_point?(value,data_source)
    #oddly this used to be data_source.object_id. which makes me think I was dealing with a nil problem
    #in some cases. Hopefully won't crop up.
    same_value_as?(value) and self.data_source_id == data_source.id
  end
  
  def trying_to_replace_current_value_with_nil?(value)
     value.nil? and !self.value.nil?
  end
  
  def debug(value)
    puts "#{date_string} - SELF.VALUE: #{self.value} / #{self.value.class} VALUE: #{value} / #{value.class}"
  end
  
  def create_new_dp(value, data_source)
    #create a new datapoint because value changed
    #need to understand how to control the rounding...not sure what sets this
    #rounding doesnt work, looks like there's some kind of truncation too.
    self.update_attributes(:current => false)
    new_dp = self.clone
    new_dp.update_attributes(:data_source_id => data_source.id, :value => value, :current => true, :created_at => Time.now, :updated_at => Time.now)
  end
  
  def restore_prior_dp(value, data_source)
    prior_dp = DataPoint.where(:date_string => date_string, :series_id => series_id, :value => value, :data_source_id => data_source.id).first
    return nil if prior_dp.nil?
    self.update_attributes(:current => false) unless self.id == prior_dp.id #this screws up... if equality is off a little
    prior_dp.increment :restore_counter
    prior_dp.current = true
    prior_dp.save
    prior_dp = DataPoint.where(:date_string => date_string, :series_id => series_id, :value => value, :data_source_id => data_source.id).first
    return prior_dp
  end
  
  def update_timestamp
    #i wonder why this wouldnt work automatically (timestamp update)
    #updating only is slightly faster than prioring. Over 269 data points the difference is 3.28 v 3.50 seconds
    #this update is not worth it. Just to update the timestamp adds a lot of time to the calculation. It's the 
    #model saving that is expensive
    #self.update_attributes(:updated_at => Time.now)
    self
  end
  
  def same_value_as?(value)
    #used to round to 3 digits but not doing that anymore. May need to revert
    #equality at very last digit (somewhere like 12 or 15) is off if rounding is not used. The find seems to work in MysQL but ruby equality fails
    self.value.round(10) == value.round(10)
    #self.value == value
  end
  
  def delete
    date_string = self.date_string
    series_id = self.series_id
    
    super

    next_of_kin = DataPoint.where(:date_string => date_string, :series_id => series_id).sort_by(&:updated_at).reverse[0]
    next_of_kin.update_attributes(:current => true) unless next_of_kin.nil?        
  end
  
  def source_type
    source_eval = self.data_source.eval
    case 
    when source_eval.index("load_from_bls")
      return :download
    when source_eval.index("load_from_download")
      return :download
    when source_eval.index("load_from_fred")
      return :download
    when source_eval.index("load_from")
      return :static_file
    else
      return :identity
    end
  end
  
  def is_pseudo_history?
    pseudo_history_sources = [
      "/Volumes/UHEROwork/data/rawdata/History/inc_hist.xls", 
      "/Volumes/UHEROwork/data/rawdata/History/bls_sa_history.xls", 
      "/Volumes/UHEROwork/data/rawdata/History/bls_histextend_date_format_correct.xls" 
    ]
    source_eval = self.data_source.eval
    pseudo_history_sources.each { |phs| return true if source_eval.index(phs) }
    return false
  end
  
  def source_type_code
    case source_type
    when :download
      return 10
    when :static_file
      return 20
    when :identity
      return 30
    else
      return 40
    end
  end

  
end
