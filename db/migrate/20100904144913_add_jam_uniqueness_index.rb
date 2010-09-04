class AddJamUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :jams, [:uid, :dir], :unique => true
  end

  def self.down
    remove_index :jams, [:uid, :dir]
  end
end
