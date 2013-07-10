class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :from_world_type_id
      t.integer :to_world_type_id
      t.decimal :rate
    end
    add_index :rates, :from_world_type_id
    add_index :rates, :to_world_type_id
    add_index :rates, [:from_world_type_id, :to_world_type_id], unique: true
  end
end
