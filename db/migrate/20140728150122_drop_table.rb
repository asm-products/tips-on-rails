class DropTable < ActiveRecord::Migration
 def self.up
    drop_table :bookmarks
  end
end
