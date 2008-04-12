class RemoveNameFromRider < ActiveRecord::Migration
  def self.up
    remove_column :riders, :name
  end

  def self.down
    add_column :riders, :name
  end
end
