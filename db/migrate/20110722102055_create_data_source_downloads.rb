class CreateDataSourceDownloads < ActiveRecord::Migration
  def self.up
    create_table :data_source_downloads do |t|
      t.string :url
      t.text :post_parameters
      t.string :save_path
      t.text :download_log, :limit => 4294967295

      t.timestamps
    end
  end

  def self.down
    drop_table :data_source_downloads
  end
end
