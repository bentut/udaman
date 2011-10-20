class AddReverse < ActiveRecord::Migration
  def self.up
    add_column :data_load_patterns, :reverse, :boolean, :default => 0
  end

  def self.down
    remove_column :data_load_patterns, :ssl_enabled
  end
end
