class CreateAremosSeries < ActiveRecord::Migration
  def self.up
    create_table :aremos_series do |t|
      t.string :name
      t.string :frequency
      t.string :description
      t.string :start
      t.string :end
      t.text :data, :limit => 4294967295
      t.text :aremos_data, :limit => 4294967295
      t.date :aremos_update_date

      t.timestamps
    end
  end

  def self.down
    drop_table :aremos_series
  end
end
