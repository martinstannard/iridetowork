class Info < ActiveRecord::Migration

  def self.up
    create_table "infos", :force => true do |t|
      t.column :key, :string
      t.column :text, :string
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
    end
  end

  def self.down
    drop_table :info
  end
end
