class AremosSeries < ActiveRecord::Base
  serialize :data, Hash
  serialize :aremos_data, Array
end
