class CreateBookmarks < ActiveRecord::Migration
  def change
  	unless table_exists? :bookmarks
    create_table :bookmarks do |t|
      t.integer :tip_id
      t.integer :user_id

      t.timestamps
    end
    	add_index :tips, [:tip_id]
    	add_index :users, [:user_id]
  	end
	end
end
