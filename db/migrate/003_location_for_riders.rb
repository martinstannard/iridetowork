## sorry, the name of this migration is wrong.
class LocationForRiders < ActiveRecord::Migration
  def self.up
    add_column(:riders, :name, :string, :limit => 40)      
  end

  def self.down
    remove_column(:riders, :name)
  end
end
