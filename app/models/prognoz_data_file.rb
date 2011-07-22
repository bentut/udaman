class PrognozDataFile < ActiveRecord::Base
  serialize :series_loaded, Array
  serialize :series_validated, Array
  serialize :output_series, Hash
  serialize :series_covered, Hash
end
