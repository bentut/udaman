class AddDataPointRestoreTally < ActiveRecord::Migration
  def self.up
    add_column :data_points, :restore_counter, :integer, :default => 0
  end

  def self.down
    remove_column :data_points, :restore_counter
  end
end
