class AddSlugToTips < ActiveRecord::Migration
  def change
    add_column :tips, :slug, :string
  end
end
