class AddDataSourcePriority < ActiveRecord::Migration
  def self.up
    add_column :data_sources, :priority, :integer, :default => 100    
  end

  def self.down
    remove_column :data_sources, :priority
  end
end
