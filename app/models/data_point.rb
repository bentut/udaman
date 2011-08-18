class DataPoint < ActiveRecord::Base
  belongs_to :series
  belongs_to :data_source
  
  def upd(value, data_source)
    new_dp = self
    
    #no changes at all
    return self if value.nil? and !self.value.nil?
    #timestamps only, 
    self.update_attributes(:updated_at => Time.now) if self.value == value and self.data_source_id == data_source.object_id
    #data source and timestamps
    self.update_attributes( :data_source_id => data_source.id ) if self.value == value and self.data_source_id != data_source.id
    #create a new datapoint because value changed
    #need to understand how to control the rounding...not sure what sets this
    #rounding doesnt work, looks like there's some kind of truncation too.
    if self.value.round(4) != value.round(4)
      puts "SELF.VALUE: #{self.value} / #{self.value.class} VALUE: #{value} / #{value.class}"
      self.update_attributes(:current => false)
      new_dp = self.clone
      new_dp.update_attributes(:data_source_id => data_source.id, :value => value, :current => true, :created_at => Time.now, :updated_at => Time.now)
    end
    new_dp
  end
  
  def delete
    date_string = self.date_string
    series_id = self.series_id
    
    super

    next_of_kin = DataPoint.where(:date_string => date_string, :series_id => series_id).sort_by(&:updated_at).reverse[0]
    next_of_kin.update_attributes(:current => true) unless next_of_kin.nil?        
  end
  
  # in the KEEP scenario, have to update the data source id because 
  # the practice is to delete previous versions 
  # of the source. The eval statement is cached with each datapoint
  # this might blow up and become unmaintainable.
  
  # def DataPoint.update(series_id, date_string, value, data_source_id = nil )
  #   value = nil if value.class == String
  #   current_point = DataPoint.first(:conditions => {:series_id => series_id, :date_string => date_string, :current => true})
  #   data_source_eval = nil
  #   if current_point.nil?
  #     # puts "Creating point for #{date_string}:#{value}"
  #     # SCENARIO: CREATE because no data point exists for this date
  #     data_source_eval = DataSource.find(data_source_id).eval unless data_source_id.nil? 
  #     DataPoint.create( :series_id => series_id, 
  #                       :date_string => date_string, 
  #                       :value => value, 
  #                       :data_source_id => data_source_id, 
  #                       :data_source_eval => data_source_eval, 
  #                       :current => true, 
  #                       :last_updated => Time.now, 
  #                       :first_updated => Time.now)
  #   else
  #     if current_point.value == value and current_point.data_source_eval == data_source_eval
  #       # puts "Keeping point for #{date_string}:#{value}"
  #       # SCENARIO: KEEP the old data point because data and source are the same
  #       current_point.update_attributes(  :last_updated => Time.now, 
  #                                         :data_source_id => data_source_id)
  #     else
  #       # SCENARIO: REPLACE the old data point because either the source or the value has changed
  #       # puts "Replacing point for #{date_string}:#{value}"
  #       unless value.nil?
  #         current_point.update_attributes(:current => false)
  #         DataPoint.create( :series_id => series_id, 
  #                           :date_string => date_string, 
  #                           :value => value, 
  #                           :data_source_id => data_source_id, 
  #                           :data_source_eval => data_source_eval, 
  #                           :current => true, 
  #                           :last_updated => Time.now, 
  #                           :first_updated => Time.now) unless value.nil?
  #       end
  #     end
  #   end
  # end #Datapoint.update
  
end
