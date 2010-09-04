class CreateJams < ActiveRecord::Migration
  def self.up
    create_table :jams do |t|
      t.string :uid
      t.string :dir

      t.timestamps
    end
    add_index :jams, :uid
  end

  def self.down
    drop_table :jams
  end
end
