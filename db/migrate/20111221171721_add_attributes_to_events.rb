class AddAttributesToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :start_at_date, :date
    add_column :events, :start_at_hour, :integer
    add_column :events, :start_at_minute, :string  #to handle 00
  end

  def self.down
    remove_column :events, :start_at_minute
    remove_column :events, :start_at_hour
    remove_column :events, :start_at_date
  end
end
