class AddSlugToUsers < ActiveRecord::Migration
  def up
    add_column :users, :slug, :string
    add_index :users, :slug

    # Generate the slugs for the existing users
    p 'Generating slugs for the existing users'
    User.find_each(&:save)
  end

  def down
    remove_column :users, :slug
  end
end
