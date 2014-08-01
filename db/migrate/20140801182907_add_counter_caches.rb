class AddCounterCaches < ActiveRecord::Migration
  def change
  	add_column :tips, :bookmarks_count, :integer, null: false, default: 0
		add_column :users, :bookmarks_count, :integer, null: false, default: 0
		add_column :users, :tips_count, :integer, null: false, default: 0
  end
end
