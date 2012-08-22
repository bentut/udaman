class RemoveDataField < ActiveRecord::Migration
  def self.up
    remove_column :series, :data
    remove_column :data_sources, :data
  end

  def self.down
    add_column :series, :data, :text, :limit => 4294967295
    add_column :data_sources, :data, :text, :limit => 4294967295
  end
end
