class CreateLoginAttempts < ActiveRecord::Migration
  def change
    create_table :login_attempts do |t|
      t.string :ip
      t.string :login

      t.timestamps
    end
  end
end
