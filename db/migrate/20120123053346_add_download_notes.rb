class AddDownloadNotes < ActiveRecord::Migration
  def self.up
    add_column :data_source_downloads, :notes, :text
  end

  def self.down
    remove_column :data_source_downloads, :notes
  end
end
