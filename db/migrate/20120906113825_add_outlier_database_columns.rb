class AddOutlierDatabaseColumns < ActiveRecord::Migration
  def self.up
    add_column :data_points, :outlier, :boolean
  end

  def self.down
    remove_column :data_points, :outlier
  end
end