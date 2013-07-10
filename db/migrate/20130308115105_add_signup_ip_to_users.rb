class AddSignupIpToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :signup_ip, :string
    add_index   :users, :signup_ip
  end
end
