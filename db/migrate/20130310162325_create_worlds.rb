class CreateWorlds < ActiveRecord::Migration
  def change
    create_table :worlds do |t|
      t.string :name
      t.string :location
      t.integer :account
      t.boolean :blocked_for_incoming
      t.boolean :blocked_for_outgoing
      t.integer :amount
      t.decimal :rate

      t.timestamps
    end
  end
end
