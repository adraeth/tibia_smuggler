class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, null: false
      t.references :order_status, null: false
      t.integer :world_from_id, null: false
      t.integer :world_to_id, null: false
      t.integer :amount_from, :amount_to
      t.string :character_from, :character_to, :ip, :rejection_reason
      t.datetime :accepted_at, :received_at, :completed_at, :rejected_at
      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :order_status_id
    add_index :orders, :world_from_id
    add_index :orders, :world_to_id
  end
end
