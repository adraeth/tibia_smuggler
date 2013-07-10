class AddReducibleAndReductionStepToRate < ActiveRecord::Migration
  def change
    add_column :rates, :reducible, :boolean, null: false, default: false
    add_column :rates, :reduction_step, :decimal, null: false, default: 0.0
  end
end
