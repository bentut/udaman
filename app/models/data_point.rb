class DataPoint < ActiveRecord::Base
  belongs_to :series
  belongs_to :data_source
end
