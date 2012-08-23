class RemoveLogField < ActiveRecord::Migration
  def self.up
    remove_column :data_source_downloads, :download_log
  end

  def self.down
    add_column :data_source_downloads, :download_log, :text, :limit => 4294967295
  end
end
