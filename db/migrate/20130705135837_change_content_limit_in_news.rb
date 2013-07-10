class ChangeContentLimitInNews < ActiveRecord::Migration
  def up
    change_column :news, :content, :text, limit: nil
  end

  def down
    change_column :news, :content, :text, limit: nil
  end
end
