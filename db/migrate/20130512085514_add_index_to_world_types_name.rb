class AddIndexToWorldTypesName < ActiveRecord::Migration
  def change
    add_index :world_types, :name, unique: true
  end
end
