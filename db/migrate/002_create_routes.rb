class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|

      t.timestamps
      t.integer :rider_id
      t.integer :from_zip
      t.integer :to_zip
      t.integer :from_location
      t.integer :to_location
    end
  end

  def self.down
    drop_table :routes
  end
end
