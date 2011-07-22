class CreateDataLoadPatterns < ActiveRecord::Migration
  def self.up
    create_table :data_load_patterns do |t|
      t.string :start_date
      t.string :frequency
      t.string :path
      t.string :worksheet
      t.string :row
      t.string :col
      t.string :last_date_read
      t.string :last_read_status

      t.timestamps
    end
  end

  def self.down
    drop_table :data_load_patterns
  end
end
