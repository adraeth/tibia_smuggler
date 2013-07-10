class ChangeLengthLimitForNewsContent < ActiveRecord::Migration
  def up
    change_column :news, :content, :text, limit: 1000
  end

  def down
    change_column :news, :content, :text, limit: 255
  end
end
