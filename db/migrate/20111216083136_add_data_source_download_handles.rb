class AddDataSourceDownloadHandles < ActiveRecord::Migration
  def self.up
    add_column :data_source_downloads, :handle, t.string
  end

  def self.down
    remove_column :data_source_downloads, :handle
  end
end
