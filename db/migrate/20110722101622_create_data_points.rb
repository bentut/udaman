class CreateDataPoints < ActiveRecord::Migration
  def self.up
    create_table :data_points do |t|
      t.integer :series_id
      t.string :date_string
      t.float :value
      t.boolean :current
      t.integer :data_source_id
      t.datetime :history

      t.timestamps
    end
  end

  def self.down
    drop_table :data_points
  end
end
