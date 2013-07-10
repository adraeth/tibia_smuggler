class AddIndexToAssignmentsUserId < ActiveRecord::Migration
  def change
    add_index :assignments, :user_id
  end
end
