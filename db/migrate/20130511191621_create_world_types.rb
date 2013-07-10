class CreateWorldTypes < ActiveRecord::Migration
  def change
    create_table :world_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
