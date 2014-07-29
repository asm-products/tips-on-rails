class AddIdToTips < ActiveRecord::Migration
  def change
  	add_column :tips, :tip_id, :integer
  end
end
