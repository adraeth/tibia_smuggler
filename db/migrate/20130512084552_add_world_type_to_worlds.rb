class AddWorldTypeToWorlds < ActiveRecord::Migration
  def change
    add_column :worlds, :world_type_id, :integer
    add_index :worlds, :world_type_id
  end
end
