class AddInitialIndices < ActiveRecord::Migration
  def self.up
    add_index(:series, :name)
    add_index(:aremos_series, :name)
    add_index(:data_points, :series_id)
    add_index(:data_sources, :series_id)
#    add_index(:data_points, :series_id)
    add_index(:data_points, [:series_id, :date_string])
  end

  def self.down
    remove_index(:series, :name)
    remove_index(:aremos_series, :name)
    remove_index(:data_points, :series_id)
    remove_index(:data_sources, :series_id)
#    remove_index(:data_points, :series_id)
    remove_index(:data_points, [:series_id, :date_string])
  end
end

