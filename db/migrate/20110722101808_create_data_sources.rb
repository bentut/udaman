class CreateDataSources < ActiveRecord::Migration
  def self.up
    create_table :data_sources do |t|
      t.integer :series_id
      t.string :description
      t.string :eval
      t.text :data, :limit => 4294967295
      t.datetime :last_run
      t.text :dependencies
      t.string :color
      t.float :runtime

      t.timestamps
    end
  end

  def self.down
    drop_table :data_sources
  end
end
