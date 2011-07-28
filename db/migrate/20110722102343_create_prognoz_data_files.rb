class CreatePrognozDataFiles < ActiveRecord::Migration
  def self.up
    create_table :prognoz_data_files do |t|
      t.string :name
      t.string :filename
      t.string :frequency
      t.text :series_loaded, :limit => 4294967295
      t.text :series_covered
      t.text :series_validated
      t.text :output_series
      t.string :output_start_date

      t.timestamps
    end
  end

  def self.down
    drop_table :prognoz_data_files
  end
end
