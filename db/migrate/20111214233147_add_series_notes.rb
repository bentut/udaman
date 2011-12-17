class AddSeriesNotes < ActiveRecord::Migration
  def self.up
    add_column :series, :investigation_notes, :text
  end

  def self.down
    remove_column :series, :investigation_notes
  end
end
