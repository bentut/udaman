class DataSourceDownload < ActiveRecord::Base
  serialize :post_parameters, Hash
  serialize :download_log, Array
end
