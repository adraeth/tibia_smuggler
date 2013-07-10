class AddIndexToAssignmentsPermissionId < ActiveRecord::Migration
  def change
    add_index :assignments, :permission_id
  end
end
