class RemoveUnneededColumnsFromUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
      t.remove :unconfirmed_email
      t.remove :password_confirmation
      t.string :username, null: false
      t.index :username
      t.remove_index :reset_password_token
    end
  end

  def down
    change_table :users do |t|
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      t.string :password_confirmation

      t.index :reset_password_token, unique: true
    end
  end
end
