class RemoveTimestampsFromWorldTypes < ActiveRecord::Migration
  def change
    remove_timestamps :world_types
  end
end
