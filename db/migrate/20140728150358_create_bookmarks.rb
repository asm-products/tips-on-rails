class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :tip_id
      t.integer :user_id
      t.timestamps
    end
    add_index :bookmarks, [:tip_id]
    add_index :bookmarks, [:user_id]
  end
end
