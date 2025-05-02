class AddFirstSigninIpAddressToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_signin_ip_address, :string
  end
end
