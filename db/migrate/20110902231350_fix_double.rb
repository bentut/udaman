class FixDouble < ActiveRecord::Migration
  def self.up
    change_column :data_points, :value, :float, :limit => 53
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "cannot go back to single precision data"
  end
end
