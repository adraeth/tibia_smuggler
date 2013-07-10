class AddIndexToPermissionsName < ActiveRecord::Migration
  def change
    add_index :permissions, :name, unique: true
  end
end
