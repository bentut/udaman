class DataSource < ActiveRecord::Base
  belongs_to :series
  has_many :data_points
end
