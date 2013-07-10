class AddIndexToWorldsName < ActiveRecord::Migration
  def change
    add_index :worlds, :name, unique: true
  end
end
