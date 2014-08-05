class AdjustTipsColumns < ActiveRecord::Migration
  def up
    change_table :tips do |t|
      t.rename :code, :body
      t.rename :code_cached, :body_cached
      t.remove :references
    end
  end

  def down
    change_table :tips do |t|
      t.rename :body, :code
      t.rename :body_cached, :code_cached
      t.string :references
    end
  end
end
