class ChangeContentTypeInNews < ActiveRecord::Migration
  def up
    change_column :news, :content, :text
  end

  def down
    change_column :news, :content, :string
  end
end
