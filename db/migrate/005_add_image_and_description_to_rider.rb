class AddImageAndDescriptionToRider < ActiveRecord::Migration
  def self.up
    add_column :riders, :image_id, :integer, :default => nil
    add_column :riders, :description, :text, :default => ''
  end

  def self.down
    remove_column :riders, :image_id
    remove_column :riders, :description
  end
end
