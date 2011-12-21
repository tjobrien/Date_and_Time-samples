class AddAmpmToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :am_pm, :string, :default => "AM"
  end

  def self.down
    remove_column :events, :am_pm
  end
end
