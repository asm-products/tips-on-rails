class AddColumnToTips < ActiveRecord::Migration
  def change
    add_column :tips, :code_cached, :text
  end
end
