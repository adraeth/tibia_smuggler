class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.datetime :date_to_show
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
