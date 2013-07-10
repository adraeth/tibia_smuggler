class AddIndexToAssignmentsBothKeys < ActiveRecord::Migration
  def change
    add_index :assignments, [:user_id, :permission_id], :unique => true
  end
end
