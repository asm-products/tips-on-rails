class AddCodeAndReferenceToTips < ActiveRecord::Migration
  def change
  	add_column :tips, :code, :string
    add_column :tips, :references, :string
  end
end
