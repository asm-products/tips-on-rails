class ChangeCodeFromStringToTextInTips < ActiveRecord::Migration
  def up
  	change_column :tips, :code, :text 
  end

  def down
  	# change_column :tips, :code, :string 
  	raise ActiveRecord::IrreversibleMigration, "Can't recover strings"
  end
end
