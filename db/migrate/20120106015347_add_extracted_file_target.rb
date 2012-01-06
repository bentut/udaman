class AddExtractedFileTarget < ActiveRecord::Migration
  def self.up
  end

  def self.down
  end
  
  def self.up
    add_column :data_source_downloads, :file_to_extract, :string
  end

  def self.down
    remove_column :data_source_downloads, :file_to_extract
  end
end
