class AddSlugToTips < ActiveRecord::Migration
  def up
    add_column :tips, :slug, :string
    add_index :tips, :slug

    # Generate the slugs for the existing tips
    p 'Generating slugs for the existing tips'
    Tip.find_each do |tip|
      tip.slug = tip.title_and_username.parameterize
      tip.save
    end
  end

  def down
    remove_column :tips, :slug
  end
end
