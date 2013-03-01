class AddLastRunMilliseconds < ActiveRecord::Migration
  def self.up
    add_column :data_sources, :last_run_in_seconds, :decimal, :precision => 17, :scale => 3
  end

  def self.down
    remove_column :data_sources, :last_run_in_seconds
  end
end
