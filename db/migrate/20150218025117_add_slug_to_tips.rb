class AddSlugToTips < ActiveRecord::Migration
  def up
    add_column :tips, :slug, :string
    add_index :tips, :slug

    # Generate the slugs for the existing tips
    p 'Generating slugs for the existing tips'
    Tip.find_each(&:save)
  end

  def down
    remove_column :tips, :slug
  end
end
