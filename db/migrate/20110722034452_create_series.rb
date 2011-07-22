class CreateSeries < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
      t.string :name
      t.string :frequency
      t.string :description
      t.integer :units
      t.boolean :seasonally_adjusted
      t.string :last_demetra_datestring
      t.text :factors
      t.string :factor_application
      t.string :prognoz_data_file_id
      t.integer :aremos_missing
      t.float :aremos_diff
      t.integer :mult
      t.text :data

      t.timestamps
    end
  end

  def self.down
    drop_table :series
  end
end
