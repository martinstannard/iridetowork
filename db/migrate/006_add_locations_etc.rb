class AddLocationsEtc < ActiveRecord::Migration
  def self.up
    create_table :locations, :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "street_address"
      t.string   "city"
      t.string   "state"
      t.string   "zip"
      t.string   "country_code"
      t.decimal  "lat",            :precision => 15, :scale => 12
      t.decimal  "lng",            :precision => 15, :scale => 12
      t.string   "precision"
      t.string   "provider"
      t.boolean  "success"
      t.string   "full_address"
    end

    remove_column :routes, :from_zip
    remove_column :routes, :to_zip

    rename_column :routes, :from_location, :from_location_id
    rename_column :routes, :to_location, :to_location_id

  end

  def self.down
    drop_table :locations
    rename_column :routes, :from_location_id, :from_location
    rename_column :routes, :to_location_id, :to_location
    add_column :routes, :from_zip, :string
    add_column :routes, :to_zip, :string
  end
end
