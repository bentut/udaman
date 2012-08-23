class CreateDsdLogEntries < ActiveRecord::Migration
  def self.up
    create_table :dsd_log_entries do |t|
      t.integer :data_source_download_id
      t.datetime :time
      t.string :url
      t.string :location
      t.string :type
      t.integer :status
      t.boolean :dl_changed

      t.timestamps
    end
  end

  def self.down
    drop_table :dsd_log_entries
  end
end
